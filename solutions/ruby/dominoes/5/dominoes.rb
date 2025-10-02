class Dominoes

  def self.chain?(dominoes, should_start_with = nil, should_end_with = nil)
    return should_start_with == should_end_with if dominoes.empty?  # chain complete, check if start and end dots match
    
    return chain?(dominoes.drop(1), *dominoes.first) if should_start_with.nil?  # start chain

    # else try to continue chain
    dominoes.each_with_index.any? do |domino, i|
      case domino
      in [^should_start_with, b]  # matches as-is
        chain?(dominoes.take(i) + dominoes.drop(i+1), b, should_end_with)
      in [a, ^should_start_with]  # matches flipped
        chain?(dominoes.take(i) + dominoes.drop(i+1), a, should_end_with)
      else
        false # doesn't match
      end
    end
  end 
end
