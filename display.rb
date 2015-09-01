require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
  include Cursor
  attr_reader :board
  attr_accessor :cursor

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = false
  end

  #white queen starts on d1
  #print a-h on top and 8-1 on side

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i,j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i,j)
    if [i,j] == @cursor_pos
      bg = :red
    elsif board[[i, j]].flagged
      bg = :blue
    elsif (i+j).odd?
      bg = :light_white
    else
      bg = :black
    end
    { background: bg }
  end

  def render
    system("clear")
    build_grid.each {|row| puts row.join}

    nil
  end

end
