class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump']
  
  def initialize(number)
    @number = number.to_i
  end

  def commands   
    ACTIONS.filter.with_index { |action, i| (@number & 1 << i).nonzero? }
              .tap { |list| list.reverse! if (@number & 1 << 4).nonzero? }
  end
end