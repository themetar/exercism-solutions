class SecretHandshake

  ACTIONS = {
    0b00001 => 'wink',
    0b00010 => 'double blink',
    0b00100 => 'close your eyes',
    0b01000 => 'jump'
  }

  REVERSE = 0b10000
  
  def initialize(number)
    @number = number
  end

  def commands   
    ACTIONS.filter { |flag_bit, _| (@number & flag_bit).nonzero? }
      .values
      .tap { |list| list.reverse! if (@number & REVERSE).nonzero? }
  end

end