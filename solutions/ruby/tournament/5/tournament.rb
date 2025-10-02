class Tournament
  ROW_TEMPLATE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"

  HEADER = ROW_TEMPLATE % %w(Team MP W D L P)

  TeamInfo = Struct.new(:matches, :win, :draw, :loss, :points)

  OPPOSITE_OUTCOME = {win: :loss, loss: :win}

  private_constant :ROW_TEMPLATE, :HEADER, :TeamInfo, :OPPOSITE_OUTCOME

  def self.tally(input)
    new(input).tally
  end

  def tally
    calculate!
    formated_string
  end
  
  private

  def initialize(input)
    @data = Hash.new { |h, k| h[k] = TeamInfo.new(0, 0, 0, 0, 0) }

    team_outcome_pairs(input) do |team, result|
      @data[team][result] += 1
    end
  end

  def opposite(result)
   OPPOSITE_OUTCOME[result] || result
  end

  def team_outcome_pairs(input)
    input.each_line do |line|  
      next if line.chomp!.empty?
      home, guest, result = line.split(';')
      result = result.to_sym
      yield home, result
      yield guest, opposite(result)
    end
  end

  def calculate!
    @data.each do |_, data|
      data.matches = data.win + data.loss + data.draw
      data.points = data.win * 3 + data.draw
    end
  end

  def formated_string
    sorted = @data.sort_by { |team_name, stats| [-stats.points, team_name] }

    HEADER + sorted.map do |team_name, stats|
      ROW_TEMPLATE % ([team_name] + stats.values)
    end.join()
  end
end
