class AssemblyLine

  CARS_PER_HOUR = 221

  def production_rate_per_hour
    CARS_PER_HOUR * @productivity_factor
  end

  def working_items_per_minute
    production_rate_per_hour.div 60
  end

  private

  def initialize(speed)
    @productivity_factor = speed * success_rate(speed)
  end

  def success_rate(speed)
    case speed
    when (1..4) then 1.0
    when (5..8) then 0.9
    when 9 then 0.8
    when 10 then 0.77
    end
  end

end
