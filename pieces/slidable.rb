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
