class Tournament
  ROW_TEMPLATE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"

  HEADER = ROW_TEMPLATE % %w(Team MP W D L P)

  TeamInfo = Struct.new(:matches, :win, :draw, :loss, :points)

  OPPOSITE_OUTCOME = {win: :loss, loss: :win}

  POINTS = {win: 3, draw: 1, loss: 0}

  private_constant :ROW_TEMPLATE, :HEADER, :TeamInfo, :OPPOSITE_OUTCOME, :POINTS

  def self.tally(input)
    new(input).tally
  end

  def tally
    sorted = @data.sort_by { |team_name, stats| [-stats.points, team_name] }

    HEADER + sorted.map do |team_name, stats|
      ROW_TEMPLATE % [team_name, *stats.values]
    end.join
  end
  
  private

  def initialize(input)
    @data = Hash.new { |h, k| h[k] = TeamInfo.new(0, 0, 0, 0, 0) }

    team_outcome_pairs(input) do |team, result|
      @data[team][result] += 1
      @data[team].points += POINTS[result]
      @data[team].matches += 1
    end
  end

  def opposite(result)
   OPPOSITE_OUTCOME[result] || result
  end

  def team_outcome_pairs(input)
    input.each_line(chomp: true) do |line|  
      next if line.empty?
      home, guest, result = line.split(';')
      result = result.to_sym
      yield home, result
      yield guest, opposite(result)
    end
  end
end
