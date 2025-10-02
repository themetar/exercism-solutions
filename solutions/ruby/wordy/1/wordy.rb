class WordProblem 
  def initialize(question)
    @question = question
  end

  def answer
    match = /^What is (.+)\?$/.match @question

    raise ArgumentError, "Badly worded" unless match

    expression = match[1]

    tokens = []
    loc = 0

    until loc == expression.length
      match = /\s*(-?\d+|plus|minus|multiplied by|divided by)/.match(expression, loc)

      raise ArgumentError, "Unknown operation" unless match

      case match[1]
      when 'plus' then tokens << '+'
      when 'minus' then tokens << '-'
      when 'multiplied by' then tokens << '*'
      when 'divided by' then tokens << '/'
      else tokens << match[1].to_i
      end

      loc += match[0].length
    end
    
    answer = tokens[0].to_i

    tokens.drop(1).each_slice(2).reduce(tokens.first) do |acc, (op, int)|
      acc.send op, int
    end
  end
end