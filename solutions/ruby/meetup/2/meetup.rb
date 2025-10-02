require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, qualifier)    
    all_weekdays = (Date.new(@year, @month, 1)..Date.new(@year, @month, -1))
                      .filter { |date| date.send(weekday.to_s + '?') }
    
    return all_weekdays.last if qualifier == :last
    
    return all_weekdays.find { |date| date.day > 12 } if qualifier == :teenth
    
    return all_weekdays[[:first, :second, :third, :fourth].index(qualifier)]
  end
end