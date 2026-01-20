require 'date'

class Meetup
  ORDER = {first: 1, second: 8, third: 15, fourth: 22, teenth: 13, last: -7}

  DAYNAMES = Date::DAYNAMES.map(&(:downcase.to_proc >> :to_sym.to_proc))

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, qualifier)
    pivot_day = Date.new(@year, @month, ORDER[qualifier])
    offset = DAYNAMES.index(weekday) - pivot_day.wday
    offset += 7 if offset < 0
    pivot_day + offset
  end
end