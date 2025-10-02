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
    _report(latest, personal_best - latest)
  end

  private

  def _report(latest, difference)
    "Your latest score was #{latest}. That's #{"#{difference} short of " if difference > 0}your personal best!"
  end
end
