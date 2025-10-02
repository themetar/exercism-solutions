module Atbash
  def self.encode(plaintext)
    ciphertext = translate(plaintext)

    ((ciphertext.length - 1) / 5).times { |i| ciphertext.insert(5 * (i + 1) + i, ' ') }
    
    ciphertext
  end

  def self.decode(ciphertext)
    translate(ciphertext)
  end

  def self.translate(text)
    text.downcase
        .delete('^a-z', '^0-9')
        .tr('a-z', ('a'..'z').to_a.reverse.join)
  end
end
