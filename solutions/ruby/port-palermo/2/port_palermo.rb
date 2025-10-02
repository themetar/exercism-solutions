module Port
  IDENTIFIER = :PALE

  TERMINAL_FOR = {
    OIL: :A,
    GAS: :A
  }

  TERMINAL_FOR.default = :B

  def self.get_identifier(city)
    city[0,4].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    cargo = ship_identifier.to_s[0,3].to_sym
    TERMINAL_FOR[cargo]
  end
end
