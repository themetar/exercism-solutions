class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum)
    @datum = datum
    @next = nil
  end
end

class SimpleLinkedList
  def initialize(object = nil)
    @latest = nil

    object.each { |d| push(Element.new(d)) } if object&.respond_to? :each
  end

  def push(element)
    if @latest.nil?
      @latest = element 
    else
      element.next = @latest
      @latest = element
    end

    return self
  end

  def pop
    element = @latest

    @latest = @latest.next unless @latest.nil?

    element
  end

  def reverse!
    rev = nil

    while (element = pop)
      element.next = rev
      rev = element
    end
    
    @latest = rev

    self
  end

  def to_a
    ary = []

    current = @latest
    until current.nil?
      ary << current.datum
      current = current.next
    end

    ary
  end
end
