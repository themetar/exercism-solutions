module Alphametics
  DIGITS = (0..9).to_a.freeze

  def self.solve(puzzle)
    words = puzzle.scan(/[A-Z]+/).map(&:chars).map(&:reverse) # reverse so that indices match base weights

    forbidden_zeros = words.map(&:last).uniq    

    max_position = words.map(&:length).max - 1

    above_line_columns_tally = 0.upto(max_position).map do |i| # each column (units, tens, etc) as a tally of letters
      words[0...-1].map { |word| word[i] } .compact.tally
    end

    below_line = words[-1]

    position_vars = 0.upto(max_position).map { |i| (above_line_columns_tally[i].keys + [below_line[i]]).uniq }

    stack = [{partial_solution: {}, position: -1, carry: 0}]

    until stack.empty? do
      stack.pop => {partial_solution:, position:, carry:}

      position += 1

      each_pairing(position_vars[position], partial_solution, forbidden_zeros) do |solution|
        # test solution down positions
        to_stack = nil
        drill_carry = carry

        position.upto(max_position) do |drill_position|
          begin
            above_line_sum = polynom_sum(above_line_columns_tally[drill_position], solution)
          rescue
            # can't sum, column contains an unresolved letter
            # break to store last candidate to stack
            break
          end

          target_digit = solution[below_line[drill_position]]

          if target_digit.nil?
            # target is unresolved letter
            # break to store candidate to stack
            break
          end

          next_carry, digit = (above_line_sum + drill_carry).divmod 10
          
          if digit == target_digit  # viable solution
            return solution if drill_position == max_position # found *the* solution

            to_stack = {partial_solution: solution, carry: next_carry, position: drill_position}
            drill_carry = next_carry
          else
            # wrong solution
            to_stack = nil  # clear to_stack, so it doesn't get saved
            break
          end

        end

        stack << to_stack unless to_stack.nil?
      
      end
      # end
    end

    return {}
  end

  # Returns polynom sum, raises an Error if a variable is missing in values
  def self.polynom_sum(polynom, values)
    polynom.inject(0) do |acc, (var, count)|
      # Would've raised an error, e.g `raise ArgumentError if values[var].nil?`
      # but next line raises NoMethod anyway when `values[var]` is nil

      acc + values[var] * count
    end
  end

  # Calls block for every combination of letter => digit pairing
  # building on any pre-set pairs provided in `partial`
  def self.each_pairing(variables, partial, zero_blacklist)
    free_vars = variables - partial.keys

    nonzero = free_vars.intersection zero_blacklist
    allowed_zeros = free_vars - nonzero

    available_digits = DIGITS - partial.values

    vars = nonzero + allowed_zeros

    (available_digits - [0]).permutation(nonzero.length) do |nonzero_permutation|
      (available_digits - nonzero_permutation).permutation(allowed_zeros.length) do |allowed_z_permutation|
        permutation = nonzero_permutation + allowed_z_permutation

        yield partial.merge(vars.zip(permutation).to_h)
      end
    end
  end
end
