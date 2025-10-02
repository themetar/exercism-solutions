class Scale
  TONES      = %w(C C# D D# E F F# G G# A A# B)
  TONES_FLAT = %w(C Db D Eb E F Gb G Ab A Bb B)
  STEP = {'M' => 2, 'm' => 1, 'A' => 3}

  attr_reader :chromatic
  
  def initialize(tonic)
    tones = %w(C a G D A E B F# e b f# c# g# d#).include?(tonic) ? TONES : TONES_FLAT
    
    @chromatic = tones.rotate(tones.find_index(tonic.capitalize))
  end

  def interval(pattern)
    pattern.each_char
      .map { |p| STEP[p] }
      .reduce([0]) { |acc, delta| acc + [(acc.last + delta) % 12] }
      .map { |i| chromatic[i] }
  end
end
