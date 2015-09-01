require_relative 'piece.rb'
class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new (8) { EmptySquare.new } }
  end

  def move(start, end_pos)
    # raise BadMoveError.new, "there's nothing at #{start}" if self[start].is_a?(EmptySquare)
    self[end_pos] = self[start]
    #
    # raise BadMoveError.new, "can't move there" unless self[start].valid_move(end_pos)?
    self[start] = EmptySquare.new
    #return true or false to PLayer depending on if move succeeded
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def in_bounds?(pos)
    pos.each do |coord|
      return false if coord > 7
      return false if coord < 0
    end
    return true
  end

end

class BadMoveError < StandardError

end
