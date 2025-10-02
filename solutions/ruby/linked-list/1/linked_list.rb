class Deque
  Node = Struct.new(:data, :prev, :next)
  
  def initialize
    @start_node = nil
    @end_node = nil
  end

  def push(data)
    node = Node.new(data, @end_node, nil)
    @end_node&.next = node
    @end_node = node
    @start_node = @end_node unless @start_node
  end

  def pop    
    @end_node, node = @end_node.prev, @end_node
    @end_node&.next = nil
    @start_node = nil if @start_node == node  # it was the *only* node
    node.data
  end

  def unshift(data)
    node = Node.new(data, nil, @start_node)
    @start_node&.prev = node
    @start_node = node
    @end_node = @start_node unless @end_node
  end

  def shift
    node, @start_node = @start_node, @start_node.next
    @start_node&.prev = nil
    @end_node = nil if @end_node == node  # it was the *only* node
    node.data
  end
end
