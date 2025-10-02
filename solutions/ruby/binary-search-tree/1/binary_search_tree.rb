class Bst
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
  end

  def insert(data)
    if data <= self.data
      if left.nil?
        self.left = Bst.new(data)
      else
        left.insert(data)
      end
    else
      if right.nil?
        self.right = Bst.new(data)
      else
        right.insert(data)
      end
    end
  end

  def each(&block)
    if block
      left.each(&block) unless left.nil?
      block.call data
      right.each(&block) unless right.nil?
    else
      Enumerator.new do |y|
        left.each { |le| y << le } if left
        y << data
        right. each { |re| y << re } if right
      end
    end
  end
end
