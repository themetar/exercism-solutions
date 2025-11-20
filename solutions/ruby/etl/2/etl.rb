module ETL
  def self.transform(old_hash)
    old_hash.each_with_object({}) do |(points, letters), new_hash|
      new_hash.merge!(letters.to_h { |letter| [letter.downcase, points] })
    end
  end
end
