class Bst
  attr_reader :data, :left, :right

  def initialize(data)
    @data = data
  end

  def insert(data)
    if data <= @data
      if @left
        @left.insert(data)
      else
        @left = Bst.new(data)
      end
    else
      if @right
        @right.insert(data)
      else
        @right = Bst.new(data)
      end
    end
  end

  def each(&block)
    if block
      @left.each(&block) if @left
      block.call data
      @right.each(&block) if @right
    else
      to_enum
    end
  end
end
