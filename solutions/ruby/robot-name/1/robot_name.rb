class Robot
  @@names = (0...(26 * 26 * 1000)).to_a.shuffle
  @@p = 0

  def initialize
    reset
  end

  def self.forget
  end

  def name
    @name
  end

  def reset
    @name = next_name
  end

  private

  def next_name
    @@p = (@@p + 1) % @@names.length
    string_representation(@@names[@@p])
  end

  def string_representation(integer)
    name = ""
    3.times do
      name = (integer % 10).to_s + name
      integer /= 10
    end

    2.times do
      name = ('A'.ord + integer % 26).chr + name
      integer /= 26
    end
    name
  end
end
