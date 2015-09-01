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
