class Clock
  attr_reader :hour, :minute

  def initialize(hour: 0, minute: 0)
    @minute = minute % 60
    @hour = (hour + minute / 60) % 24
    @minute += 60 if @minute < 0
    @hour += 24 if @hour < 0
  end

  def +(other)
    Clock.new(hour: hour + other.hour, minute: minute + other.minute)
  end

  def -(other)
    Clock.new(hour: hour - other.hour, minute: minute - other.minute)
  end

  def ==(other)
    hour == other.hour && minute == other.minute
  end

  def to_s
    "%02d:%02d" % [@hour, @minute]
  end
end
