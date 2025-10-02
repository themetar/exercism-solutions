class Affine

  ALPHABET = ('a'..'z').to_a.freeze

  GROUP_SIZE = 5

  def initialize(a, b)
    @a = a
    @b = b
    @m = ALPHABET.length

    gcd_and_inverses = ExtendedEucledean.new(@m, @a)

    raise ArgumentError if gcd_and_inverses.gcd != 1 # a-key and alphabet length are not coprime

    @inverse_a = gcd_and_inverses.inverses(1)
  end

  def encode(plaintext)
    plaintext.downcase                           # to lowercase
             .gsub(/[a-z]/, encoding_swap)       # replace (encode) letters
             .scan(/[a-z]|\d/)                   # filter letters and digits
             .each_slice(GROUP_SIZE).map(&:join) # group by five letters
             .join(' ')                          # join groups with spaces
  end

  def decode(ciphertext)
    ciphertext.gsub(/[a-z]/, decoding_swap)  # replace (decode) letters
              .gsub(' ', '')                 # remove spaces
  end

  private

  def encoding_swap
    # hash of char => encoded char
    # block gets called when key (plain char) does not exist in hash
    # effectively memoizing the encoding function (implemented by the block)
    @encoding_swap ||= Hash.new do |h, char|
      char_index = ALPHABET.index(char)
      cipher_index = (@a * char_index + @b) % @m
      h[char] = ALPHABET[cipher_index]
    end
  end

  def decoding_swap
    # hash of cipher char => original char
    @decoding_swap ||= Hash.new do |h, char|
      char_index = ALPHABET.index(char)
      deciph_index = @inverse_a * (char_index - @b) % @m
      h[char] = ALPHABET[deciph_index]
    end
  end

end

##
# Extended Eucledean algorithm
# https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Description
#
class ExtendedEucledean

  attr_reader :gcd

  def inverses(index)
    @inverses[index]
  end

  private

  def initialize(a, b)
    r_now, r_next = a, b
    s_now, s_next = 1, 0
    t_now, t_next = 0, 1

    until r_next.zero?
      q, r_tmp = r_now.divmod r_next

      r_now, r_next = r_next, r_tmp
      s_now, s_next = s_next, s_now - q * s_next
      t_now, t_next = t_next, t_now - q * t_next
    end

    @gcd = r_now
    @inverses = [s_now, t_now]
  end

end
