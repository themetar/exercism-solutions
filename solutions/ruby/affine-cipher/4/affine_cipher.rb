class Affine

  ALPHABET = ('a'..'z').to_a.freeze

  GROUP_SIZE = 5

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

  def initialize(a, b)
    gcd_and_inverses = ExtendedEucledean.new(ALPHABET.length, a)

    raise ArgumentError if gcd_and_inverses.gcd != 1 # a-key and alphabet length are not coprime

    inverse_a = gcd_and_inverses.inverses(1)

    @encode_proc = proc { |n| (a * n + b) % ALPHABET.length }

    @decode_proc = proc { |n| inverse_a * (n - b) % ALPHABET.length }
  end

  def encoding_swap
    @encoding_swap ||= replacement_hash @encode_proc
  end

  def decoding_swap
    @decoding_swap ||= replacement_hash @decode_proc
  end

  def replacement_hash(encryption_proc)
    # hash of char => [encrypt|decrypt]ed char
    # block gets called when key (input char) does not exist in hash
    # effectively memoizing the encoding function (implemented by the block)
    Hash.new do |hash, char|
      hash[char] = char.then(&ALPHABET.method(:index))
                       .then(&encryption_proc)
                       .then(&ALPHABET.method(:[]))
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
      r_now, q, r_next = r_next, *r_now.divmod(r_next)
      s_now, s_next = s_next, s_now - q * s_next
      t_now, t_next = t_next, t_now - q * t_next
    end

    @gcd = r_now
    @inverses = [s_now, t_now]
  end

end
