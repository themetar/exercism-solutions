module ETL
  def self.transform(old_hash)
    old_hash.map do |points, letters|
               letters.map(&:downcase)
                      .zip([points].cycle)
                      .to_h
             end
            .reduce(&:merge)
  end
end
