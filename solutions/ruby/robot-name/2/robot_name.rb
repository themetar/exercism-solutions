class Robot
  @@name_pool = ("AA000".."ZZ999").to_a
  @@pool_size = @@name_pool.length

  def initialize
    @name = take_name
  end

  def self.forget
    @@pool_size = @@name_pool.length
  end

  def name
    @name
  end

  def reset
    @name = take_name(name)
  end

  private

  def take_name(swap = nil)
    raise RuntimeError.new("no more names") if @@pool_size.zero?

    indx = rand(@@pool_size)
    new_name = @@name_pool[indx]
    if swap.nil?
      @@name_pool[indx] = @@name_pool[@@pool_size - 1]
      @@name_pool[@@pool_size - 1] = new_name
      @@pool_size -= 1
    else
      @@name_pool[@@name_pool.index(swap)] = new_name
      @@name_pool[indx] = swap
    end
    new_name
  end
end
