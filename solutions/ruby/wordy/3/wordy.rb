class WordProblem

  QUESTION_REGEX = /^What is (.+)\?$/
  NUMBER_REGEX = /-?\d+/
  WORDS_REGEX = /#{NUMBER_REGEX}|plus|minus|multiplied by|divided by|\w+/

  def answer
    tokens = @expression.scan(WORDS_REGEX).map(&method(:to_value))

    tokens.drop(1).each_slice(2).reduce(tokens.first) do |acc, (operator, number)|
      raise ArgumentError, "Syntax error" unless operator.is_a? Symbol
      raise ArgumentError, "Syntax error" unless number.is_a? Integer

      acc.send operator, number
    end
  end

  private

  def initialize(question)
    _, @expression = * QUESTION_REGEX.match(question)

    raise ArgumentError, "Badly worded" unless @expression
  end

  def to_value(instruction)
    case instruction
    when 'plus' then :+
    when 'minus' then :-
    when 'multiplied by' then :*
    when 'divided by' then :/
    when NUMBER_REGEX then instruction.to_i
    else
      raise ArgumentError, "Unknown operation"
    end
  end

end