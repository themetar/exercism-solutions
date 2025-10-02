class Pool
  def initialize(items)
    @pool = items
    @size = @pool.length
  end

  def lease_item
    raise RuntimeError.new("no more items") if @size.zero?

    indx = rand(@size)
    @size -= 1
    @pool[indx], @pool[@size] = @pool[@size], @pool[indx] # swap chosen with last
    @pool[@size] # return last (chosen)
  end

  def return_item(item)
    raise RuntimeError.new("pool full, can't receive an intem") if @size == @pool.length

    indx = @pool.index(item)
    @pool[indx], @pool[@size] = @pool[@size], @pool[indx]
    @size += 1
  end

  def reboot
    @size = @pool.length
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
