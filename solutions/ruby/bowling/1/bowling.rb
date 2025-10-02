class Game
  FRAME_PINS = 10
  STRIKE_FRAME = [FRAME_PINS].freeze

  def initialize
    @frames = []
    @current_frame = []
    @rolls_remaining = 20
  end

  def roll(pins)
    raise BowlingError.new("Bad ammount of pins: #{pins}") unless pins.between?(0, FRAME_PINS)

    raise BowlingError.new("Game already finished") if finished?

    @current_frame << pins

    raise BowlingError.new("Can't down more than 10 pins in a single frame: #{@current_frame}") if @current_frame.sum > FRAME_PINS

    @rolls_remaining -= 1
    @rolls_remaining -= 1 if @frames.length < 10 && @current_frame == STRIKE_FRAME # strike uses two roll slots

    if @current_frame == STRIKE_FRAME || @current_frame.length == 2 || @rolls_remaining.zero?
      @frames << @current_frame
      @current_frame = []
    end

    # award bonus rolls
    if @frames.length == 10 && @current_frame == []
      @rolls_remaining += 1 if @frames.last.sum == FRAME_PINS   # 1 extra for spare
      @rolls_remaining += 1 if @frames.last == STRIKE_FRAME     # 1 more if it's actually a strike
    end
  end

  def score
    raise BowlingError.new("Game is not yet finished: #{@rolls_remaining} remaining rolls") unless finished?

    padding = [[0]] * (@frames.length < 12 ? 12 - @frames.length : 0) 

    frame_scores = (@frames + padding).each_cons(3).map do |frame, next_frame, after_next|
      if frame.sum == FRAME_PINS  # strike or spare
        (frame + next_frame + after_next)[0,3].sum
      else
        frame.sum
      end
    end

    frame_scores.sum
  end

  def finished?
    @rolls_remaining.zero?
  end

  class BowlingError < StandardError; end
end
