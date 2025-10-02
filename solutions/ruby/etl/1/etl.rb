module ETL
  def self.transform(old_hash)
    old_hash.each_with_object({}) do |(key, values), new_hash|
      values.each { |letter| new_hash[letter.downcase] = key }
    end
  end
end
