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
    "Your latest score was #{latest}. " + motivation
  end

  private

  def motivation
	difference = personal_best - latest
    if difference > 0
	  "That's #{difference} short of your personal best!" 
	else
	  "That's your personal best!"
	end
  end
end
