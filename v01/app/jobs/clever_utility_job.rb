class CleverUtilityJob < ApplicationJob
  queue_as :default

  after_enqueue do |job|
    ActionCable.server.broadcast 'web_events_channel', job_id: job.job_id, request: arguments[0], status: 'waiting'
  end

  after_perform do |job|
    ActionCable.server.broadcast 'web_events_channel', job_id: job.job_id, status: @status, jobret: @msg
  end

  def perform(*args)
    logger.info "Executing Job with arguments: #{args}"
    l = args[0].size
    c = ActiveRecord::Base.connection
    escaped_cmd = args[0].gsub("'", "''")
    @status = 'completed'
    begin
      c.execute("CALL QCMDEXC('#{escaped_cmd}', #{l})")
    rescue Exception => e
      @status = 'failed'
      @msg = "#{e}"
    end
  end
end
