require 'byebug'

class Piece
  attr_reader :color, :board, :directions
  attr_accessor :flagged, :pos, :first_move

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @first_move = true
    @flagged = false
  end

  def update_pos(pos)
    @pos = pos
  end

  def move_into_check?(end_pos)
    dupedboard = TestBoard.new(board)
    dupedboard.move(self.pos, end_pos)
    dupedboard.in_check?(self.color)
  end

  def valid_moves
    moves.reject do |move|
      move_into_check?(move)
    end
  end

  def dup
    self.class.new(self.color, self.pos, self.board)
  end

  def moves
    []
  end


  def is_enemy?(pos)
    return false unless board.in_bounds?(pos)
    board[pos].color != self.color && !board[pos].is_a?(EmptySquare)
  end

  def is_ally?(pos)
    return false unless board.in_bounds?(pos)
    board[pos].color == self.color
  end

  def is_empty_and_in_bounds?(pos)
    board.in_bounds?(pos) && board[pos].is_a?(EmptySquare)
  end

end
