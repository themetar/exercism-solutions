module Pangram
  ALPHABET_COUNT = 26
  DOWNCASE_AZ = /[a-z]/

  def self.pangram?(sentence)
    sentence.downcase.scan(DOWNCASE_AZ).uniq.length == ALPHABET_COUNT
  end
end
