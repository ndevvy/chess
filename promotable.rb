module Promotable
  PAWN_ROW_GOALS = {black: 7, white: 0}
  PAWN_CHOICES = {k: Knight, r: Rook, q: Queen, b: Bishop}

  def pawn_promoted(end_pos)
    puts "The guy at #{end_pos} is a #{self[end_pos].class}"
    return false unless self[end_pos].is_a?(Pawn)
    end_pos[0] == PAWN_ROW_GOALS[self[end_pos].color]
  end

  def choose_pawn_promotion(end_pos)
    puts "The pawn did it!  Choose a piece:  R, B, K, Q"
    choice = gets.chomp.split(//)[0].downcase.to_sym # need to handle bad input
    setup_piece(self[end_pos].color, end_pos, PAWN_CHOICES[choice])
  end
end
