module ParallelLetterFrequency

  def self.count(texts)
    ractors = texts.map do |text|
      Ractor.new(text) do |text|        
        text.gsub(/[^\p{Letter}]/, "").downcase.each_grapheme_cluster.tally
      end
    end

    ractors.each_with_object({}) { |r, total| total.merge!(r.take) { |_, a, b| a + b } }
  end
  
end
