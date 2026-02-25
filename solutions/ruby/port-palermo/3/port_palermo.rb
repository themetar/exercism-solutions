module Port

  IDENTIFIER = :PALE

  def self.get_identifier(city, length: 4)
    city[0, length].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    case get_identifier(ship_identifier, length: 3)
    when :OIL, :GAS then :A
    else :B
    end
  end

end
