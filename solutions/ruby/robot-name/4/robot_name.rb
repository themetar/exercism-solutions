class Pool
  def initialize(items)
    @pool = items
    @size = @pool.length
  end

  def lease_item
    raise RuntimeError.new("no more items") if @size.zero?

    index = draw_available_index
    item = @pool[index]
    remove_from_available(index)
    item
  end

  def return_item(item)
    raise RuntimeError.new("pool full, can't receive an intem") if @size == @pool.length

    return_to_available(@pool.index(item))
  end

  def reboot
    @size = @pool.length
  end

  private

  def draw_available_index
    rand(@size)
  end

  def remove_from_available(index)
    @size -= 1
    @pool[index], @pool[@size] = @pool[@size], @pool[index]
  end

  def return_to_available(index)
    @pool[index], @pool[@size] = @pool[@size], @pool[index]
    @size += 1
  end
end

class Robot
  @@name_pool = Pool.new(("AA000".."ZZ999").to_a)

  def initialize
    @name = @@name_pool.lease_item
  end

  def self.forget
    @@name_pool.reboot
  end

  def name
    @name
  end

  def reset
    old_name = @name
    @name = @@name_pool.lease_item
    @@name_pool.return_item(old_name)
  end
end
