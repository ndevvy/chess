class King < Piece
  include Steppable
  DIFFS = [[1, 1], [1, 0], [1, -1], [0, -1],
           [-1, -1], [-1, 0], [-1, 1], [0, 1]]

  def to_s
    "\u265A".encode('utf-8')
  end
end
