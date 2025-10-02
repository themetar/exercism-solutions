class LogLineParser

  attr_reader :message, :log_level
  
  def initialize(line)
    @log_level, @message = line.match(/\[(.+)\]: (.+)/)[1, 2]
    @message.strip!
    @log_level.downcase!
  end

  def reformat
    message << ' (' << log_level << ')'
  end

end
