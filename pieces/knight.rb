class Knight < Piece
  include Steppable

  DIFFS = [[2, -1], [2, 1], [-2, -1], [-2, 1],
           [1, -2], [1, 2], [-1, -2], [-1, 2]]

   def to_s
     "\u265E".encode('utf-8')
   end
end
