class Cipher
  ALPHABET_SIZE = 26
  A = 'a'.freeze

  attr_reader :key

  def initialize(key = nil)
    raise ArgumentError if /[^a-z]/ =~ key || key&.empty?

    @key = key || 100.times.with_object('') { |_, key| key << rand_character }
  end

  def encode(message)
    proccess_text(message, :+)
  end

  def decode(ciphertext)
    proccess_text(ciphertext, :-)
  end

  private

    def numeric(string)
      string.each_char.map { |char| char.ord - A.ord }
    end

    def key_numeric
      @key_ord ||= numeric(key)
    end

    def proccess_text(text, operation)
      numeric(text)
        .map.with_index do |numeric, index|
          numeric.send(operation, key_numeric[index % key_numeric.length]) % ALPHABET_SIZE
        end
        .map { |numeric| (A.ord + numeric).chr }
        .join
    end

    def rand_character
      (A.ord + rand(ALPHABET_SIZE)).chr
    end
end
