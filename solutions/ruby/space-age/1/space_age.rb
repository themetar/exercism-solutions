class SpaceAge
  EARTH_YEAR = 31557600
  
  PLANET_COEF = {
    "mercury" => 0.2408467,
    "venus" => 0.61519726,
    "earth" => 1,
    "mars" => 1.8808158,
    "jupiter" => 11.862615,
    "saturn" => 29.447498,
    "uranus" => 84.016846,
    "neptune" => 164.79132
  }.freeze
  
  def initialize(seconds)
    @age_in_seconds = seconds
  end

  PLANET_COEF.each do |planet, coef|
    define_method(("on_" + planet).to_sym) do
      @age_in_seconds.to_f / (EARTH_YEAR * coef)
    end
  end
end