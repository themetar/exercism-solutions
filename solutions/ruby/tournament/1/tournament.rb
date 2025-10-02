class Tournament
  ROW_TEMPLATE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"

  HEADER = ROW_TEMPLATE % %w(Team MP W D L P)

  def self.tally(input)
    new(input).tally
  end

  def initialize(input)
    @data = {}

    team_outcome_pairs(triplets(input)).each do |team, result|
      @data[team] = {matches: 0, win: 0, draw: 0, loss: 0, points: 0} if @data[team].nil?
      @data[team][result] += 1
    end
  end

  def tally
    @data.each do |team, data|
      data[:matches] = data[:win] + data[:loss] + data[:draw]
      data[:points] = data[:win] * 3 + data[:draw]
    end

    sorted = @data.sort { |ta, tb|
      (tb.last[:points] <=> ta.last[:points]) * 10 + (ta.first <=> tb.first)
    }

    matrix = sorted.map { |array| [array.first] + array.last.values }

    HEADER + matrix.map do |row|
      ROW_TEMPLATE % row
    end.join()
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

  def team_outcome_pairs(triplets)
    triplets.reduce([]) do |acc, triple|
      home, guest, result = triple
      result = result.to_sym
      acc + [[home, result], [guest, opposite(result)]]
    end
  end
end
