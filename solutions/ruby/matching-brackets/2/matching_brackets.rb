module Brackets
  PAIRS = {
    '[' => ']',
    '{' => '}',
    '(' => ')'
  }.freeze

  OPENERS = Set.new(PAIRS.keys).freeze
  CLOSERS = Set.new(PAIRS.values).freeze

  def self.paired?(string)
    bracket_stack = string.chars.each_with_object([]) do |char, stack|
      if OPENERS.include? char
        stack << char
      elsif CLOSERS.include? char
        return false if PAIRS[stack.pop] != char   
      end
    end

    bracket_stack.empty?
  end
end
