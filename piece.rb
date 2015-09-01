require 'byebug'

class Piece


  attr_reader :color, :pos, :board, :directions
  attr_accessor :flagged

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @flagged = false
  end

  def update_pos(pos)
    @pos = pos
  end



  def is_enemy?(pos)
    return false unless board.in_bounds?(pos)
    board[pos].color != self.color
  end

  def is_ally?(pos)
    return false unless board.in_bounds?(pos)
    board[pos].color == self.color
  end

end

class Pawn < Piece
DIFFS = {
  up: [-1, 0],
  down: [1, 0],
  upright:  [-1, 1],
  upleft:   [-1, -1],
  downleft: [1, -1],
  downright: [1, 1]
}

  def initialize
    super
    @first_move = true
    @direction = color == :white ? :up : :down
  end

  def valid_moves
    # pos + direction valid if not blocked
    #
  end

  def possible_moves
    # check if enemies at corners
    # something in front
  end

  def to_s
    color == white ? "\u2659".encode('utf-8') : "\u265F".encode('utf-8')
  end


end

class SteppingPiece < Piece
DIFFS = []

  def possible_moves
    self.class::DIFFS.map do |diff|
      [pos[0] + diff[0], pos[1] + diff[1]]
    end
  end

  def valid_moves
    self.possible_moves.select do |pos|
      board.in_bounds?(pos) && !is_ally?(pos)
    end
  end
end

class SlidingPiece < Piece
  DIFFS = {     downright:[1, 1],
                 down:     [1, 0],
                 up:       [-1, 0],
                 upright:  [-1, 1],
                 upleft:   [-1, -1],
                 downleft: [1, -1],
                 right:    [0, 1],
                 left:     [0, -1] }

  def valid_moves
    # array of valid moves
    valids = []
    self.directions.each do |direction| # subclass pieces will need to define their directions
      current_pos = pos
      while board.in_bounds?(current_pos) && board[current_pos].is_a?(EmptySquare)
        valids << current_pos
        current_pos = move_in_direction(current_pos, direction)
      end
        valids << current_pos if is_enemy?(current_pos)
        puts "#{current_pos} is enemy: #{is_enemy?(current_pos)}"
    end
    valids.uniq - [pos]
  end

  def move_in_direction(current, dir)
    new_dir = []
    new_dir << current[0] + DIFFS[dir][0]
    new_dir << current[1] + DIFFS[dir][1]

    new_dir
  end

end

class Queen < SlidingPiece
  def initialize(color, pos, board)
    super
    @directions = MOVE_DIFFS.keys
  end

  def to_s
    color == white ? "\u2655".encode('utf-8') : "\u265B".encode('utf-8')
  end
end

class Rook < SlidingPiece
  def initialize(color, pos, board)
    super
    @directions = [:left, :right, :up, :down]
  end

  def to_s
    color == white ? "\u2656".encode('utf-8') : "\u265C".encode('utf-8')
  end
end


end

class Bishop < SlidingPiece
  def initialize(color, pos, board)
    super
    @directions = [:upright, :downright, :upleft, :downleft]
  end

  def to_s
    color == white ? "\u2657".encode('utf-8') : "\u265D".encode('utf-8')
  end
end


end

class King < SteppingPiece
  DIFFS = [[1, 1], [1, 0], [1, -1], [0, -1],
           [-1, -1], [-1, 0], [-1, 1], [0, 1]]

  def to_s
    color == white ? "\u2654".encode('utf-8') : "\u265A".encode('utf-8')
  end
end

class Knight < SteppingPiece
  DIFFS = [[2, -1], [2, 1], [-2, -1], [-2, 1],
           [1, -2], [1, 2], [-1, -2], [-1, 2]]

   def to_s
     color == white ? "\u2658".encode('utf-8') : "\u265E".encode('utf-8')
   end

end

class EmptySquare < Piece

  def initialize
    @color = nil
  end

  def to_s
    "   "
  end

end
