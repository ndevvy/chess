require_relative 'board.rb'
require_relative 'player.rb'

class Chess
  attr_reader :current_player, :player_one, :player_two, :board

  def initialize
    @board = Board.new
    @player_one = HumanPlayer.new("player1", @board)
    @player_two = HumanPlayer.new("player2", @board)
    @current_player = player_one
  end

  def play
    until game_over?
      @current_player.get_move
      switch_players!
    end
  end


  def switch_players!
    if @current_player == @player_two
      @current_player = @player_one
    else
      @current_player = @player_two
    end
  end

  def game_over?
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  a = Board.new
  game = Chess.new
  # queen = Queen.new(:white, [4,5], a)
  # a[[4,5]] = queen
  # a[[5,5]] = Bishop.new(:black, [5,5], a)
  # bishop = Bishop.new(:white, [4, 4], a)
  # a[[4,4]] = bishop
  # rook = Rook.new(:white, [1,3], a)
  # a[[1,3]] = rook
  # knight = Knight.new(:white, [4, 4], a)
  # a[[4,4]] = knight
  # pawn = Pawn.new(:black, [1, 5], a)
  # a[[1,5]] = pawn
  #
  # valid = pawn.moves
  # valid.each do |pos|
  #    a[pos].flagged = true
  # end
  # Display.new(game.board).render
  # game.play
  puts a.find_king(:white)

end
