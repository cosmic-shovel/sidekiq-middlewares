class MysqlConnectionPoolMiddleware
  def call(worker, job, queue)
    begin
      yield
    rescue => e
      puts e.inspect
    end

    begin
      ActiveRecord::Base.clear_active_connections!()
    rescue => e
      puts e.inspect
    end
  end
end
