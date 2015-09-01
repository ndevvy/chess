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
    elsif board[[i, j]].flagged
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

  def render(errors=[])
    system("clear")
    build_grid.each {|row| puts row.join}
    puts "   A  B  C  D  E  F  G  H"
    errors.each do |error|
      puts error
    end

    nil
  end

end
