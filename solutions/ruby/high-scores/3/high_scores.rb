class HighScores
  attr_reader :scores

  def initialize (scores)
    @scores = scores
  end

  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def personal_top
    scores.max(3)
  end

  def report
    "Your latest score was #{latest}. " + _report()
  end

  private

  def _report
	difference = personal_best - latest
    return "That's #{difference} short of your personal best!" if difference > 0
	return "That's your personal best!"
  end
end
