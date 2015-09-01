class King < Piece
  include Steppable
  DIFFS = [[1, 1], [1, 0], [1, -1], [0, -1],
           [-1, -1], [-1, 0], [-1, 1], [0, 1]]

  CASTLE_DIFFS = { left: [[0,-1], [0,-2], [0,-3]],
             right: [[0,1], [0,2]] }

  def to_s
    "\u265A".encode('utf-8')
  end


    def castle_check
      valid_castles = []
      valid_castles << add_diffs([0,-2]) if castle_path(:left) && first_move_left_rook
      valid_castles << add_diffs([0,2]) if castle_path(:right) && first_move_right_rook
      valid_castles
    end

    def first_move_right_rook
      board[add_diffs([0,3])].first_move
    end

    def first_move_left_rook
      board[add_diffs([0,-4])].first_move
    end

    def castle_path(dir)
      CASTLE_DIFFS[dir].all? { |diff| is_empty_and_in_bounds?(add_diffs(diff)) }
    end

    def add_diffs(diff)
      [diff[0] + pos[0], diff[1] + pos[1]]
    end

    def valid_moves
      moves = super
      if first_move
        moves += castle_check
      end
      moves
    end

end
