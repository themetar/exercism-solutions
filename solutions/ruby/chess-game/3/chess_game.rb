module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    RANKS.include?(rank) && FILES.include?(file) 
  end

  def self.nickname(first_name, last_name)
    (first_name[...2] + last_name[-2...]).upcase
  end

  def self.move_message(first_name, last_name, square)
    file, rank = square.chars

    nick = nickname(first_name, last_name)

    return "#{nick} moved to #{square}" if valid_square?(rank.to_i, file)

    "#{nick} attempted to move to #{square}, but that is not a valid square"
  end
end
