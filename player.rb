require_relative 'display.rb'

class Player
  def initialize(name = "Player One", board)
    @name = name
    @board = board
    @display = Display.new(board)
  end

  def get_move
  end

end

class HumanPlayer < Player

  def get_move
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
      @display.render
      start_pos = @display.get_input
      @display.render
      end_pos = @display.get_input
    end

    @board.move(start_pos, end_pos)
  end

  def get_valid_move
    successful_move = nil
    until successful_move
      successful_move = get_move
    end
  end

end
