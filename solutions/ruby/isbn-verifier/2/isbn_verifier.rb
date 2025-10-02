module IsbnVerifier
  def self.valid?(string)
    ISBN.new(string).valid?
  end

  class ISBN
    private

    def initialize(string)
      @string = string.delete '-'
    end

    def valid_format?
      @string.length == 10 &&
      /[0-9]{9}[0-9X]/ =~ @string
    end

    def checksum
      @string.each_char.map { |char| ('0'..'9') === char ? char.to_i : 10 }
      .zip(10.downto 1)
      .sum { |digit, coef| digit * coef }
    end

    def valid_checksum?
       checksum % 11 == 0
    end

    public

    def valid?
      valid_format? && valid_checksum?
    end
  end
end

    

    