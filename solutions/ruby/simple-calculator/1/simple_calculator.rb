class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation, "#{operation} not supported." unless ALLOWED_OPERATIONS.include?(operation)

    raise ArgumentError, "Invalid argument: #{first_operand}." unless Numeric === first_operand
    raise ArgumentError, "Invalid argument: #{second_operand}." unless Numeric === second_operand

    return 'Division by zero is not allowed.' if operation == '/' && second_operand == 0

    result = first_operand.send(operation, second_operand)

    "#{first_operand} #{operation} #{second_operand} = #{result}"
  end
end
