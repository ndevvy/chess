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
    if is_empty_and_in_bounds?(next_move_forward)
      moves << next_move_forward
      if @first_move && is_empty_and_in_bounds?(two_moves_forward)
        moves << two_moves_forward
      end
    end
    moves += can_attack
  end

  def next_move_forward
    [DIFFS[direction][0] + pos[0], pos[1]]
  end

  def two_moves_forward
    [(2* DIFFS[direction][0]) + pos[0], pos[1]]
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
