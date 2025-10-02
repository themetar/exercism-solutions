class Tournament
  ROW_TEMPLATE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"

  HEADER = ROW_TEMPLATE % %w(Team MP W D L P)

  TeamInfo = Struct.new(:matches, :win, :draw, :loss, :points)

  def self.tally(input)
    new(input).tally
  end

  def initialize(input)
    @data = Hash.new { |h, k| h[k] = TeamInfo.new(0, 0, 0, 0, 0) }

    team_outcome_pairs(input).each do |team, result|
      @data[team][result] += 1
    end
  end

  def tally
    calculate()
    formated_string
  end

  private

  def opposite(result)
    case result
    when :win then :loss
    when :loss then :win
    else result
    end
  end

  def triplets(string)
    string.chomp.lines.map { |line|
      line.chomp.split(";")
    }
  end

  def team_outcome_pairs(input)
    triplets(input).map do |home, guest, result|
      result = result.to_sym
      [[home, result], [guest, opposite(result)]]
    end .flatten(1)
  end

  def calculate
    @data.each do |team, data|
      data.matches = data.win + data.loss + data.draw
      data.points = data.win * 3 + data.draw
    end
  end

  def formated_string
    sorted = @data.sort_by { |record| [-record.last.points, record.first] }

    HEADER + sorted.map do |record|
      ROW_TEMPLATE % ([record.first] + record.last.values)
    end.join()
  end
end
