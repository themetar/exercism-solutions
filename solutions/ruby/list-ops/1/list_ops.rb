module ListOps
  def self.arrays(list)
    count = 0
    list.each { |_| count += 1 }
    count
  end

  def self.reverser(list)
    Array.new(arrays(list)) { |i| list[-i - 1] }
  end

  def self.concatter(*lists)
    size = sum_reducer(mapper(lists) { |l| arrays(l) })

    Array.new(size).tap do |result|
      i = 0
      lists.each do |list|
        list.each do |element|
          result[i] = element
          i += 1
        end
      end
    end
  end

  def self.mapper(list)
    Array.new(arrays(list)) do |i|
      yield list[i]
    end
  end

  def self.filterer(list)
    [].tap do |result|
      list.each do |element|
        result << element if yield element
      end
    end
  end

  def self.sum_reducer(list)
    sum = 0
    list.each { |element| sum += element }
    sum
  end

  def self.factorial_reducer(list)
    product = 1
    list.each { |element| product *= element }
    product
  end
end
