module ParallelLetterFrequency
  REJECT = " \t\n\r!?;,.-—’'\"/:{}[]()0123456789"

  def self.count(texts)
    threads = texts.map do |text|
      Thread.new(text) do |text|
        tally = Hash.new(0)
        
        text.each_char { |char| tally[char.downcase] += 1 }
        
        tally.reject { |k, _| REJECT.include? k }
      end
    end

    threads.each(&:join)

    threads.reduce({}) { |acc, th| acc.merge(th.value) { |_, a, b| a + b } }
  end
end
