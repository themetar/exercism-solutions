class Robot
  STEPS = {
    north: [0, 1],
    south: [0, -1],
    east: [1, 0],
    west: [-1, 0]
  }.freeze

  DIRECTIONS = %i(north east south west)

  attr_reader :coordinates
  
  def initialize
    @direction_index = 0
    @coordinates = [0, 0]
  end

  def orient(direction)
    index = DIRECTIONS.index(direction)
    
    raise ArgumentError if index.nil?

    @direction_index = index
  end

  def bearing
    DIRECTIONS[@direction_index]
  end

  def turn_right
    @direction_index = (@direction_index + 1) % DIRECTIONS.length
  end

  def turn_left
    @direction_index = (@direction_index - 1) % DIRECTIONS.length
  end

  def at(x, y)
    @coordinates = [x, y]
  end

  def advance
    step = STEPS[DIRECTIONS[@direction_index]]

    @coordinates.length.times { |i| @coordinates[i] += step [i] }
  end
end

class Simulator
  INSTRUCTIONS = {
    R: :turn_right,
    L: :turn_left,
    A: :advance
  }

  def instructions(string)
    string.each_char.map { |char| INSTRUCTIONS[char.to_sym] }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, string)
    instructions(string).each { |command| robot.send(command) }
  end
end
