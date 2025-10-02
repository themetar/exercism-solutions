module RailFenceCipher
  def self.encode(message, rails_count)
    line = ''

    rails_count.times do |i|
      each_rail_index(i, rails_count, message.length) do |text_index|
        line << message[text_index]
      end
    end

    line
  end

  def self.decode(ciphertext, rails_count)
    message = ' ' * ciphertext.length

    ctext_index = 0

    rails_count.times do |rail|
      each_rail_index(rail, rails_count, message.length) do |text_index|
        message[text_index] = ciphertext[ctext_index]
        ctext_index += 1
      end
    end

    message
  end

  # Calls a block for every index that falls on the given rail up to some max
  # 
  def self.each_rail_index(rail, rails_count, string_length)
    index = rail  # startin index

    if rails_count == 1 # single rail
      offsets = [1]
    elsif rail == 0 || rail == rails_count - 1  # edge rail
      offsets = [(rails_count - 1) * 2]
    else  # non-edge rail
      # number of following rails times 2, number of preceding rails times 2 
      offsets = [(rails_count - 1 - rail) * 2, rail * 2]
    end

    offsets.cycle do |offset|
      break unless index < string_length

      yield index

      index += offset
    end
  end
end
