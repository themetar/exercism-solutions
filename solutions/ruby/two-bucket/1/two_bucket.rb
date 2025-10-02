class TwoBucket
  def initialize(size_one, size_two, target_liters, start_bucket)
    @size_one = size_one
    @size_two = size_two

    # set up queue with first step
    if start_bucket == "one"
      queue = [ [size_one, 0, 1] ]  # bucket_one, bucket_two, step
    else
      queue = [ [0, size_two, 1] ]
    end

    # visited states
    seen = []

    # test states and populate queue with next steps until the solution is found
    loop do
      state = queue.shift

      one, two, step = state

      if one == target_liters || two == target_liters
        @moves = step
        @goal_bucket = one == target_liters ? "one" : "two"
        @other_bucket = one == target_liters ? two : one
        break
      end

      seen << [one, two]

      next_states = potential_states(state)
                      .reject { |s| seen.include?(s[0,2]) } # already visited
                      .reject { |one, two, _| one == @size_one && two == 0 || one == 0 && two == @size_two }  # forbidden by problem instructions
      
      queue.concat(next_states)

      break if queue.empty? # solution can't be found
    end
  end

  attr_reader :moves, :goal_bucket, :other_bucket

  private

    def potential_states(state)
      one, two, step = state

      step += 1

      amount_to_pour_in_two = [one, @size_two - two].min
      amount_to_pour_in_one = [two, @size_one - one].min

      [
        # empty buckets
        [0, two, step],
        [one, 0, step],
        # fill buckets
        [@size_one, two, step],
        [one, @size_two, step],
        # pour buckets
        [one - amount_to_pour_in_two, two + amount_to_pour_in_two, step],
        [one + amount_to_pour_in_one, two - amount_to_pour_in_one, step]
      ]
    end
end