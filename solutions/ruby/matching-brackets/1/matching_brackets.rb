module Brackets
  PAIRS = {
    ']' => '[',
    '}' => '{',
    ')' => '('
  }

  def self.paired?(string)
    opening = PAIRS.values
    closing = PAIRS.keys

    bracket_stack = []

    string.each_char do |char|
      if opening.include? char
        bracket_stack << char
      elsif closing.include? char
        return false if bracket_stack.empty?
        return false if bracket_stack.last != PAIRS[char]

        bracket_stack.pop
      end
    end

    return false unless bracket_stack.empty?

    return true
  end
end
