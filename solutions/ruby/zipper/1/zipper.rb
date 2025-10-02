Node = Struct.new(:data, :left, :right)

class Zipper
  Zip = Struct.new(:data, :side, :branch)

  attr_reader :value

  def self.from_tree(tree)
    Zipper.new(tree.data, tree.left, tree.right)
  end

  def initialize(value, left, right, history = [])
    @value = value
    @left = left
    @right = right
    @history = history
  end

  def to_tree
    tree = Node.new(@value, @left, @right)
    @history.reverse_each do |zip|
      tree = Node.new(zip.data, zip.side == :left ? zip.branch : tree, zip.side == :right ? zip.branch : tree)      
    end
    tree
  end

  def left
    return nil unless @left

    Zipper.new(@left.data, @left.left, @left.right, @history + [Zip.new(@value, :right, @right)])
  end

  def right
    return nil unless @right

    Zipper.new(@right.data, @right.left, @right.right, @history + [Zip.new(@value, :left, @left)])
  end

  def up
    zip = @history.last

    return nil unless zip

    node = Node.new(@value, @left, @right)

    Zipper.new(zip.data, zip.side == :left ? zip.branch : node, zip.side == :right ? zip.branch : node, @history[0...-1])
  end

  def set_value(value)
    Zipper.new(value, @left, @right, @history)
  end

  def set_left(node)
    Zipper.new(@value, node, @right, @history)
  end

  def set_right(node)
    Zipper.new(@value, @left, node, @history)
  end

  def ==(other)
    to_tree == other.to_tree
  end
end
