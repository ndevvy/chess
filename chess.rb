require_relative 'board.rb'
require_relative 'player.rb'

class Chess
  attr_reader :current_player, :player_one, :player_two, :board

  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
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
  game = Chess.new(a, HumanPlayer.new("player1", a), HumanPlayer.new("player2", a))
  # queen = Queen.new(:white, [4,4], a)
  # a[[5,5]] = Bishop.new(:black, [5,5], a)
  # bishop = Bishop.new(:white, [4, 4], a)
  # rook = Rook.new(:white, [1,3], a)
  knight = Knight.new(:white, [4, 4], a)

  valid = knight.valid_moves
  valid.each do |pos|
    a[pos].flagged = true
  end
  Display.new(game.board).render
end
