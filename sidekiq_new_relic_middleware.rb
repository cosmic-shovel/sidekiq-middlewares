class SidekiqNewRelicMiddleware
  def call(worker, job, queue)
    event_data = {}

    begin
      event_data = {
        job_name: job["class"],
        job_args: job["args"],
        created_at: job["created_at"],
        enqueued_at: job["enqueued_at"],
        success: true,
        error: nil
      }
    rescue => e
      dmsg(e)
    end

    begin
      yield
    rescue => e
      # nr report error
      puts e.inspect
      NewRelic::Agent.notice_error(e)
      event_data[:success] = false
      event_data[:error] = e.message
    end

    begin
      NewRelic::Agent.record_custom_event("SidekiqJob", event_data)
    rescue => 
      puts e.inspect
    end
  end
end
