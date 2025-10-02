module FlattenArray

  # Ruby's built-in solution: flatten (to flatten) + compact (to remove nil)
  #
  # def self.flatten(array)
  #   array.flatten.compact
  # end

  def self.flatten(array)
    out = []

    until array.empty?
      first, *rest = array
      if Array === first
        array = first.concat rest
      else
        out << first unless first.nil?
        array = rest
      end
    end

    out
  end

end
