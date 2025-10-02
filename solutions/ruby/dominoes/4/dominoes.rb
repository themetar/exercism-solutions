class Dominoes

  def self.chain?(dominoes)
    return true if dominoes.empty?

    dominoes.each_with_index.any? do |domino, i|
      rest_of_dominoes = dominoes.take(i) + dominoes.drop(i + 1) 
      test_chain(rest_of_dominoes, domino.last, domino.first)
    end
  end

  private

    def self.test_chain(dominoes, should_start_with, should_end_with)
      return should_start_with == should_end_with if dominoes.empty?  # chain complete, check if start and end dots match

      # else try to continue chain
      dominoes.each_with_index.any? do |domino, i|
        case domino
        in [^should_start_with, b]  # matches as-is
          test_chain(dominoes.take(i) + dominoes.drop(i+1), b, should_end_with)
        in [a, ^should_start_with]  # matches flipped
          test_chain(dominoes.take(i) + dominoes.drop(i+1), a, should_end_with)
        else
          false # doesn't match
        end
      end
    end  
end
