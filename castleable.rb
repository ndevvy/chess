module Castleable
ROOK_CASTLING_MOVES = {
  [:right, :white] => [[7,7], [7,5]],
  [:right, :black] => [[0,7], [0,5]],
  [:left, :white] => [[7,0], [7,3]],
  [:left, :black] => [[0,0], [0,3]]
}
  def king_castled(start, end_pos) # outputs [:direction, :color]
    output = []
    return false unless self[end_pos].is_a?(King)
    if start[1] - end_pos[1] == -2
      output << :right
    elsif start[1] - end_pos[1] == 2
      output << :left
    else
      false
    end
    output << self[end_pos].color
  end

  def move_rook_after_castle(king_info)
    end_pos = ROOK_CASTLING_MOVES[king_info][1]
    start = ROOK_CASTLING_MOVES[king_info][0]
    self[end_pos] = self[start]
    self[start] = EmptySquare.new
    self[end_pos].pos = end_pos
    self[end_pos].first_move
  end
end
