class Element

  attr_reader :datum
  attr_accessor :next

  def initialize(datum, succ = nil)
    @datum = datum
    @next = succ
  end

end

class SimpleLinkedList

  def initialize(object = [])
    @head = nil

    object.each { |d| @head = Element.new(d, @head) }
  end

  def push(element)
    element.next = @head
    @head = element

    self
  end

  def pop
    element, @head = @head, @head && @head.next

    element
  end

  def reverse!
    rev = nil

    each do |element|
      element.next = rev
      rev = element
    end
    
    @head = rev

    self
  end

  def to_a
    each.map(&:datum)
  end

  def each
    return to_enum unless block_given?

    current = @head
    while current
      succ = current.next
      yield current
      current = succ
    end
  end

end
