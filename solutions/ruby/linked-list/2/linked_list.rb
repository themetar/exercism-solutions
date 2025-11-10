class Deque
  Node = Struct.new(:data, :prev, :next)
  
  def initialize
    @start_node = nil
    @end_node = nil
  end

  def push(data)
    node = Node.new(data, @end_node, nil)
    if empty?
      @start_node = @end_node = node
    else
      @end_node.next = node
      @end_node = node
    end
  end

  def pop    
    @end_node, node = @end_node.prev, @end_node
    @end_node&.next = nil
    @start_node = nil if @start_node == node  # it was the *only* node
    node.data
  end

  def unshift(data)
    if empty?
      push(data)
    else
      node = Node.new(data, nil, @start_node)
      @start_node.prev = node
      @start_node = node
    end
  end

  def shift
    node, @start_node = @start_node, @start_node.next
    @start_node&.prev = nil
    @end_node = nil if @end_node == node  # it was the *only* node
    node.data
  end

  def count
    node = @start_node
    counter = 0
    while node do
      counter += 1
      node = node&.next 
    end
    counter
  end

  def delete(data)
    node = @start_node
    until node.nil? || node.data == data
      node = node.next
    end
    unless node.nil?
      node.prev&.next = node.next
      node.next&.prev = node.prev
      @start_node = node.next if node == @start_node
      @end_node = node.prev if node == @end_node
    end
  end

  def empty?
    @start_node.nil?
  end
end
