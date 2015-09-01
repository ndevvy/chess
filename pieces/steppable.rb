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
