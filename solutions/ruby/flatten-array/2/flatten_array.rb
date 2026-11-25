module FlattenArray

  # Ruby's built-in solution: flatten (to flatten) + compact (to remove nil)
  #
  # def self.flatten(array)
  #   array.flatten.compact
  # end

  def self.flatten(array)
    out = []

    until array.empty?
      first, *array = array

      next if first.nil?

      case first
      when Array then array = first + array
      else out << first
      end
    end

    out
  end

end
