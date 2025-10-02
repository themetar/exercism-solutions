class LogLineParser

  attr_reader :message, :log_level

  def reformat
    "#{message} (#{log_level})"
  end

  private
  
  def initialize(line)
    _, @log_level, @message = *line.match(/\[(.+)\]: (.+)/)
    @message.strip!
    @log_level.downcase!
  end

end
