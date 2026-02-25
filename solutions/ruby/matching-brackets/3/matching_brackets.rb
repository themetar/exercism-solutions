module Brackets

  PAIRS = {
    '[' => ']',
    '{' => '}',
    '(' => ')'
  }.freeze

  OPENER = PAIRS.method(:key?)
  CLOSER = PAIRS.method(:value?)

  def self.paired?(string)
    string.each_char.with_object([]) do |char, stack|
      case char
      when OPENER
        stack << char
      when CLOSER
        return false if PAIRS[stack.pop] != char   
      end
    end
    .then(&:empty?)
  end

end
