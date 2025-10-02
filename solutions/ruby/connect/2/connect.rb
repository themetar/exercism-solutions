class Board

  NEIGHBORS = [
    [0, -1], [1, -1], # up, up-right
    [-1, 0], [1, 0],  # left, right
    [-1, 1], [0, 1]   # down-left, down
  ]

  private

  attr_accessor :board

  def initialize(board)
    self.board = board.map { |row| row.scan(/[XO.]/) }
  end

  # Enumerates x, y coordinates of neighbouring cells
  # The coordinate space is a 2-D grid mimicking a hexagonal network
  def neighbors(x, y)
    return to_enum(:neighbors, x, y) unless block_given?
    
    NEIGHBORS.each do |dx, dy|
      neighbor_y = y + dy
      next if neighbor_y < 0 || neighbor_y >= board.length
      neighbor_x = x + dx
      next if neighbor_x < 0 || neighbor_x >= board[neighbor_y].length
      yield neighbor_x, neighbor_y
    end
  end

  # Puts `paint_with` marker in [x, y] cell of `board` if it currently is marked with `test_for`
  # Returns a boolean value showing wether the cell was painted   
  def paint_cell(x, y, test_for, paint_with)
    return false unless board[y][x] == test_for
    return false unless neighbors(x, y).any? { |x, y| board[y][x] == paint_with }

    board[y][x] = paint_with
    true
  end

  public

  def winner
    board[0].map! { |stone| stone == 'O' ? :A : stone }

    board.each { |row| row[0] = :B if row[0] == 'X' }

    continue_loop = true

    while continue_loop
      continue_loop = false

      board.each_index do |y|
        board[y].each_index do |x|
          continue_loop ||= paint_cell(x, y, 'O', :A)
          continue_loop ||= paint_cell(x, y, 'X', :B)
        end
      end
    end

    return 'O' if board.last.any?(:A)
    return 'X' if board.map(&:last).any?(:B)
    return ''
  end

end
