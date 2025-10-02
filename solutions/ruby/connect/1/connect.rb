class Board
  def initialize(board)
    @board = board.map { |row| row.scan(/[XO\.]/) }
  end

  def winner
    board = Array.new(@board.length) { |i| @board[i].dup }

    board[0].length.times { |x| board[0][x] = 'A' if board[0][x] == 'O' }

    board.length.times { |y| board[y][0] = 'B' if board[y][0] == 'X' }

    continue_loop = true

    while continue_loop
      continue_loop = false

      for y in (0...board.length) do
        for x in (0...board[y].length) do
          continue_loop ||= paint_cell(x, y, board, 'O', 'A')

          continue_loop ||= paint_cell(x, y, board, 'X', 'B')
        end
      end
    end

    return 'O' if board.last.any? { |cell| cell == 'A' }
    return 'X' if board.any? { |row| row.last == 'B' }
    return ''
  end

  private

  # Returns x, y coordinates of neighbouring cells
  # The coordinate space is a 2-D grid mimicking a hexagonal network
  def neighbors(x, y)
    [
      [0, -1], [1, -1], # up, up-right
      [-1, 0], [1, 0],  # left, right
      [-1, 1], [0, 1]   # down-left, down
    ].map { |dx, dy| [x + dx, y + dy] }
      .reject { |x, y| x < 0 || y < 0 || y >= @board.length || x >= @board[y].length }
  end

  # Puts `paint_with` marker in [x, y] cell of `board` if it currently is marked with `test_for`
  # Returns a boolean value showing wether an action was taken   
  def paint_cell(x, y, board, test_for, paint_with)
    if board[y][x] == test_for
      if neighbors(x, y).any? { |x, y| board[y][x] == paint_with }
        board[y][x] = paint_with
        return true
      end
    end

    return false
  end
end
