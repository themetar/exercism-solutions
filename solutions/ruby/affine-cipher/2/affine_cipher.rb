class Affine
  ALPHABET = ('a'..'z').to_a.freeze
  A_ORD = 'a'.ord

  GROUP_SIZE = 5

  def initialize(a, b)
    @a = a
    @b = b

    @m = ALPHABET.length

    gcd, _, @inverse = gcd_and_inverses(@m, a)

    raise ArgumentError if gcd != 1 # a-key and alphabet length are not coprime

    # hash of char => encoded char
    # block gets called when key (plain char) does not exist in hash
    # effectively memoizing the encoding function (implemented by the block)
    @enc_replacement = Hash.new do |_, char|
      char_i = ALPHABET.index(char)
      cipher_i = (@a * char_i + @b) % @m
      ALPHABET[cipher_i]
    end

    # hash of cipher char => original char
    @dec_replacement = Hash.new do |_, char|
      char_i = ALPHABET.index(char)
      deciph_i = @inverse * (char_i - b) % @m
      ALPHABET[deciph_i]
    end
  end

  def encode(plaintext)
    plaintext.downcase                                            # to lowercase
              .gsub(/[a-z]/, @enc_replacement)                    # replace (encode) letters
              .gsub(/[^a-z\d]/, '')                               # remove non-letters and non-digits
              .split('')                                          # convert to array, so you can use each_slice
              .each_slice(GROUP_SIZE).map { |group| group.join }  # group by five letters
              .join(' ')                                          # join groups with spaces
  end

  def decode(ciphertext)
    ciphertext.gsub(/[a-z]/, @dec_replacement)  # replace (decode) letters
              .gsub(' ', '')                    # remove spaces
  end

  private

  ##
  # Extended Eucledean algorithm
  # https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Description
  #
  def gcd_and_inverses(m, a)
    r = [m, a, nil]
    s = [1, 0, nil]
    t = [0, 1, nil]

    loop do
      q, r[2] = r[0].divmod r[1]
      s[2] = s[0] - q * s[1]
      t[2] = t[0] - q * t[1]

      break if r[2].zero?

      r.rotate! # shift to the left, _[2] will be overwritten in next loop
      s.rotate!
      t.rotate!

    end

    [r[1], s[1], t[1]]
  end 
end
