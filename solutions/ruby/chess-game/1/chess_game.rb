module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    RANKS.include?(rank) && FILES.include?(file) 
  end

  def self.nick_name(first_name, last_name)
    (first_name[...2] + last_name[-2...]).upcase
  end

  def self.move_message(first_name, last_name, square)
    file, rank = square.chars
    if valid_square?(rank.to_i, file)
      "#{nick_name(first_name, last_name)} moved to #{square}"
    else
      "#{nick_name(first_name, last_name)} attempted to move to #{square}, but that is not a valid square"
    end
  end
end
