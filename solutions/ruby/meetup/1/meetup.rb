require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, qualifier)    
    all_weekdays = (1..31).map { |dom| Time.new(@year, @month, dom).to_date }
                      .filter { |date| date.send(weekday.to_s + '?') && date.month == @month }
    
    return all_weekdays.send(qualifier) if qualifier == :first || qualifier == :last
    
    return all_weekdays.find { |date| date.day > 12 } if qualifier == :teenth
    
    return all_weekdays[1 + [:second, :third, :fourth].index(qualifier)]
  end
end