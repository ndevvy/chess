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
