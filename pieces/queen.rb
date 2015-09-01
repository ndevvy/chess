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
