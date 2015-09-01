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

  def move_into_check?
    # dup board and perform move; see if player is in check after move
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

class Pawn < Piece
  DIFFS = {
  up: [-1, 0],
  down: [1, 0],
  # upright:  [-1, 1],
  # upleft:   [-1, -1],
  # downleft: [1, -1],
  # downright: [1, 1]
}

  attr_reader :direction

  def initialize(color, pos, board)
    super

    @direction = color == :white ? :up : :down
  end

  def moves
    moves = []
    if is_empty_and_in_bounds?([DIFFS[direction][0] + pos[0], pos[1]])
      moves << [DIFFS[direction][0] + pos[0], pos[1]]
      if @first_move && is_empty_and_in_bounds?([(2* DIFFS[direction][0]) + pos[0], pos[1]])
        moves << [(2* DIFFS[direction][0]) + pos[0], pos[1]]
      end
    end
    moves += can_attack
  end

  def can_attack # returns attackable corners
    corners = [[DIFFS[direction][0] + pos[0], pos[1] +1],
              [DIFFS[direction][0] + pos[0], pos[1] - 1]]
    corners.select { |corner| board.in_bounds?(corner) && is_enemy?(corner) }
  end

  def possible_moves
    # check if enemies at corners
    # something in front
  end

  def to_s
    "\u265F".encode('utf-8')
  end


end

module Steppable
  def possible_moves
    self.class::DIFFS.map do |diff|
      [pos[0] + diff[0], pos[1] + diff[1]]
    end
  end

  def moves
    self.possible_moves.select do |pos|
      board.in_bounds?(pos) && !is_ally?(pos)
    end
  end
end


module Slidable
  DIFFS = {     downright:[1, 1],
                 down:     [1, 0],
                 up:       [-1, 0],
                 upright:  [-1, 1],
                 upleft:   [-1, -1],
                 downleft: [1, -1],
                 right:    [0, 1],
                 left:     [0, -1] }

  def moves
    # array of valid moves
    # debugger
    valids = []
    self.directions.each do |direction| # subclass pieces will need to define their directions
      current_pos = move_in_direction(pos, direction)
      while is_empty_and_in_bounds?(current_pos)
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

class Queen < Piece
  include Slidable

  def initialize(color, pos, board)
    super
    @directions = DIFFS.keys
  end

  def to_s
    "\u265B".encode('utf-8')
  end
end

class Rook < Piece
  include Slidable

  def initialize(color, pos, board)
    super
    @directions = [:left, :right, :up, :down]
  end

  def to_s
    "\u265C".encode('utf-8')
  end
end




class Bishop < Piece
  include Slidable

  def initialize(color, pos, board)
    super
    @directions = [:upright, :downright, :upleft, :downleft]
  end

  def to_s
    "\u265D".encode('utf-8')
  end
end


class King < Piece
  include Steppable
  DIFFS = [[1, 1], [1, 0], [1, -1], [0, -1],
           [-1, -1], [-1, 0], [-1, 1], [0, 1]]

  def to_s
    "\u265A".encode('utf-8')
  end
end

class Knight < Piece
  include Steppable

  DIFFS = [[2, -1], [2, 1], [-2, -1], [-2, 1],
           [1, -2], [1, 2], [-1, -2], [-1, 2]]

   def to_s
     "\u265E".encode('utf-8')
   end
end

class EmptySquare < Piece

  def initialize(color=nil, pos=nil, board=nil)
  end

  def to_s
    " "
  end

end
