class HighScores
  attr_reader :scores

  def initialize (scores)
    @scores = scores
  end

  def latest
    @scores.last
  end

  def personal_best
    @scores.max
  end

  def personal_top
    @scores.sort { |a, b| b <=> a } [0, 3]
  end

  def report
    msg_if_short = if (difference = personal_best - latest) > 0
      "#{difference} short of "
    else "" end
    "Your latest score was #{latest}. That's #{msg_if_short}your personal best!"
  end
end
