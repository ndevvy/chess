require_relative 'display.rb'

class Player

  attr_reader :color, :board

  def initialize(name = "Player One", board, color)
    @name = name
    @board = board
    @display = Display.new(board)
    @color = color
  end

  def get_move
  end

end

class HumanPlayer < Player

  def get_move
    errors = []
    begin
      start_pos, end_pos = nil, nil

      until start_pos && board[start_pos].color == self.color
        @display.render(errors)
        start_pos = @display.get_input
      end

      @board[start_pos].flagged = true
      highlighted = @board[start_pos].valid_moves || []
      highlighted.each do |valid|
        @board[valid].flagged = true
      end


      until end_pos
        @display.render
        end_pos = @display.get_input
      end

      @board[start_pos].flagged = false

      highlighted.each do |valid|
        @board[valid].flagged = false
      end

      @board.move(start_pos, end_pos)
    rescue BadMoveError
      errors = ["invalid move"]
      retry
    end

      @display.render
  end

  def get_valid_move
    successful_move = nil
    until successful_move
      successful_move = get_move
    end
  end

end
