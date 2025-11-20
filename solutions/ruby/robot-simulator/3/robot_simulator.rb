class Robot
  STEPS = {
    north: [0, 1],
    south: [0, -1],
    east: [1, 0],
    west: [-1, 0]
  }.freeze

  DIRECTIONS = %i(north east south west).freeze

  attr_reader :coordinates

  def orient(direction)
    index = DIRECTIONS.index(direction) or raise ArgumentError, "Direction not valid"

    self.direction_index = index
  end

  def bearing
    DIRECTIONS[direction_index]
  end

  def turn_right
    self.direction_index = (direction_index + 1) % DIRECTIONS.length
  end

  def turn_left
    self.direction_index = (direction_index - 1) % DIRECTIONS.length
  end

  def at(x, y)
    self.coordinates = [x, y]
  end

  def advance
    step = STEPS[DIRECTIONS[direction_index]]

    self.coordinates = coordinates.zip(step).map(&:sum)
  end

  private

  attr_writer :coordinates

  attr_accessor :direction_index

  def initialize
    self.direction_index = 0
    self.coordinates = [0, 0]
  end

end

class Simulator
  INSTRUCTIONS = {
    "R" => :turn_right,
    "L" => :turn_left,
    "A" => :advance
  }.freeze

  def instructions(string)
    string.each_char.map(&INSTRUCTIONS)
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, string)
    instructions(string).each(&robot.method(:send))
  end
end
