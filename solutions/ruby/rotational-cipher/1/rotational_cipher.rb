module RotationalCipher
  ALPHABET = ('a'..'z').to_a.freeze
  ALPHABET_CAPS = ('A'..'Z').to_a.freeze

  def self.rotate(input, rot)
    input.tr((ALPHABET + ALPHABET_CAPS).join, (ALPHABET.rotate(rot) + ALPHABET_CAPS.rotate(rot)).join)
  end
end
