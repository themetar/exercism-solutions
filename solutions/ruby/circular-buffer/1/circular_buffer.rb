class CircularBuffer
  def initialize(size)
    @memory = Array.new(size)
    @index_pointer = 0
    @count = 0
  end

  def read
    raise BufferEmptyException.new if @count.zero?

    item = @memory[@index_pointer]
    increment_pointer()
    @count -= 1

    item
  end

  def write(data)
    raise BufferFullException.new if @count == @memory.length
    
    @memory[(@index_pointer + @count) % @memory.length] = data
    @count += 1
  end

  def write!(data)
    if @count == @memory.length
      @memory[@index_pointer] = data
      increment_pointer()
    else
      write(data)
    end
  end

  def clear
    @count = 0
  end

  class BufferEmptyException < Exception
  end

  class BufferFullException < Exception
  end

  private

    def increment_pointer
      @index_pointer = (@index_pointer + 1) % @memory.length
    end
end
