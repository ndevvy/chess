require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
  include Cursor
  attr_reader :board
  attr_accessor :cursor, :selected

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = nil
  end


  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    rowstring = "#{8 - i} "
    row.map.with_index do |piece, j|
      color_options = colors_for(i,j)
      if j == 0
        rowstring + " #{piece.to_s} ".colorize(color_options)
      else
        " #{piece.to_s} ".colorize(color_options)
      end
    end
  end

  def colors_for(i,j)
    if [i,j] == @cursor_pos
      bg = :red
    elsif [i,j] == @selected || @current_selection.include?([i,j])
      bg = :yellow
    elsif (i+j).odd?
      bg = :light_blue
    else
      bg = :green
    end

    if board[[i,j]].color == :white
      color = :white
    elsif board[[i,j]].color == :black
      color = :black
    end

    { background: bg, color: color }
  end

  def selected_valid_moves
    return [] if selected.nil?
    board[selected].valid_moves
  end

  def render(errors=[])
    system("clear")
    @current_selection = selected_valid_moves
    grid = build_grid
    grid.each {|row| puts row.join}
    puts "   A  B  C  D  E  F  G  H"

    @current_selection = []

    errors.each do |error|
      puts error
    end

    nil
  end

end
