class BinarySearch
  def initialize(sorted_array)
    @array = sorted_array
  end

  def search_for(item)
    left = 0; right = @array.length
    index = 0
    until (right - left).zero? || @array[index] == item
      index = (left + right) / 2
      right = index if item < @array[index]
      left = index + 1 if @array[index] < item
    end
    @array[index] == item ? index : nil
  end
end
