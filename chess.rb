require_relative 'board.rb'
require_relative 'player.rb'

class Chess
  attr_reader :current_player, :player_one, :player_two, :board

  def initialize
    @board = Board.new
    @player_one = HumanPlayer.new("player1", @board, :white)
    @player_two = HumanPlayer.new("player2", @board, :black)
    @current_player = player_one
  end

  def play
    until game_over?
      @current_player.get_move
      switch_players!
    end
    puts "Checkmate!"
  end


  def switch_players!
    if @current_player == @player_two
      @current_player = @player_one
    else
      @current_player = @player_two
    end
  end

  def game_over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play

end
