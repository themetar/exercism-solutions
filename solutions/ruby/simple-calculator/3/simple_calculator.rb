class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    raise ArgumentError, "Invalid argument: #{first_operand}." unless first_operand.is_a? Numeric
    raise ArgumentError, "Invalid argument: #{second_operand}." unless second_operand.is_a? Numeric

    case operation
    when *ALLOWED_OPERATIONS
      result = first_operand.send(operation, second_operand)
    else
      raise UnsupportedOperation, "#{operation} not supported."
    end

    "#{first_operand} #{operation} #{second_operand} = #{result}"
  rescue ZeroDivisionError
    'Division by zero is not allowed.'
  end
end
