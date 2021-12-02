require 'logger'

module CustomLogger

  def logger
    # Logger.new(STDOUT)
    @@log ||= Logger.new("log_#{Time.now.strftime('%y_%h_%d_%H_%M_%S')}.txt")
  end

end