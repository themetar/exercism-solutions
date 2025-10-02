class AssemblyLine
  CARS_PER_HOUR = 221

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    total_cars = @speed * CARS_PER_HOUR

    case @speed
    when (1..4) then total_cars * 1.0
    when (5..8) then total_cars * 0.9
    when 9 then total_cars * 0.8
    when 10 then total_cars * 0.77
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).to_i
  end
end
