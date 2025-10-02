class Crypto
  attr_reader :ciphertext
  
  def initialize(message)  
    normalized = message.tr('A-Z', 'a-z')
                  .gsub(/[^\w]/, '')

    if normalized == ''
      @ciphertext = ''
      return
    end

    side = Math.sqrt(normalized.length)

    if side == side.to_i
      r = c = side.floor.to_i
    else
      c = side.ceil.to_i
      r = (normalized.length.to_f / c).ceil.to_i
    end

    @ciphertext = normalized.ljust(c * r, ' ')     # pad string with spaces
                    .each_char.each_slice(c).to_a  # create matrix of chars
                    .transpose                     # transpose rows and columns
                    .map(&:join).join(' ')         # join rows (former columns)
  end
end
