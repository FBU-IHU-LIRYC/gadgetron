
#include "Worker.h"

#include <chrono>
#include <future>

#include "connection/stream/common/External.h"
#include "connection/stream/common/ExternalChannel.h"

using namespace Gadgetron::Core;
using namespace Gadgetron::Server::Connection::Stream;

namespace {

    template<class T>
    std::chrono::milliseconds time_since(std::chrono::time_point<T> instance) {
        return std::chrono::duration_cast<std::chrono::milliseconds>(
                std::chrono::steady_clock::now() - instance
        );
    }
}

namespace Gadgetron::Server::Connection::Stream {

    Worker::Worker(
            const Address &address,
            std::shared_ptr<Serialization> serialization,
            std::shared_ptr<Configuration> configuration
    ) : address(address) {
        channel = std::make_unique<ExternalChannel>(
                connect(address, configuration),
                std::move(serialization),
                std::move(configuration)
        );
    }

    void Worker::load_changed() { for (auto &f : load_callbacks) { f(); } }

    void Worker::on_failure(std::function<void()> callback) {
        fail_callbacks.push_back(std::move(callback));
    }

    void Worker::on_load_change(std::function<void()> callback) {
        load_callbacks.push_back(std::move(callback));
    }

    long long Worker::current_load() const {
        std::lock_guard<std::mutex> guard(mutex);

        auto current_job_duration_estimate = std::max(
                timing.latest.count(),
                time_since(jobs.front().start).count()
        );

        return current_job_duration_estimate * jobs.size();
    }

    std::future<Message> Worker::push(Message message) {

        Job job {
            std::chrono::steady_clock::now(),
            std::promise<Message>()
        };

        auto future = job.response.get_future();

        {
            std::lock_guard<std::mutex> guard(mutex);
            channel->push_message(std::move(message));
            jobs.push_back(std::move(job));
        }

        load_changed();

        return future;
    }


    std::thread Worker::start(ErrorHandler &error_handler) {

        ErrorHandler nested_handler{
            error_handler,
            boost::apply_visitor([](auto a) { return to_string(a); }, address)
        };

        return nested_handler.run([=]() { handle_inbound_messages(); });
    }

    void Worker::close() {
        channel->close();
    }

    void Worker::handle_inbound_messages() {

        try {
            while(true) process_inbound_message(channel->pop());
        }
        catch (std::exception) {
            fail_pending_messages(std::current_exception());
        }
    }

    void Worker::process_inbound_message(Core::Message message) {

        Job job;
        {
            std::lock_guard<std::mutex> guard(mutex);
            job = std::move(jobs.front()); jobs.pop_front();
            timing.latest = time_since(job.start);
        }

        load_changed();

        job.response.set_value(std::move(message));
    }

    void Worker::fail_pending_messages(std::exception_ptr e) {

        for (auto &f : fail_callbacks) { f(); }
        for (auto &job : jobs) {
            job.response.set_exception(e);
        }
    }
}