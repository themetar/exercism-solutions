class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump']
  
  def initialize(number)
    @number = (number.is_a? Integer) && number || 0
  end

  def commands   
    list = ACTIONS.filter.with_index do |action, i|
      @number & (1 << i) != 0
    end

    list.reverse! unless (@number & (1 << 4)).zero?

    list
  end
end