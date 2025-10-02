class Dominoes

  def self.chain?(dominoes)
    return true if dominoes.empty?

    dominoes_bag = dominoes.map(&:sort).tally

    options_at_step = [generate_options(dominoes_bag.keys)]

    chain = []

    until options_at_step.empty?
      if options_at_step.last.empty?
        # test success
        return true if dominoes_bag.all? { |_, count| count == 0 } && chain.first.first == chain.last.last

        # if not succeeded
        dominoes_bag[chain.pop.sort] += 1 unless chain.empty? # return last domino
        options_at_step.pop # remove empty array
        next  # continue loop
      else
        domino = options_at_step.last.shift

        dominoes_bag[domino.sort] -= 1 # take from bag

        chain << domino

        options_at_step << generate_options(dominoes_bag.select { |_, count| count > 0 } .keys, domino)
      end      
    end

    false
  end

  private

    def self.generate_options(unique_dominoes, for_domino = nil)
      options = []

      unique_dominoes.each do |a, b|
        options << [a, b]
        options << [b, a] unless a == b
      end

      for_domino ? options.select { |a, _| for_domino.last == a } : options
    end
  
end