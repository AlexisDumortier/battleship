require  './lib/cell'

class Board

  attr_reader :cells

  def initialize
    @cells = make_cells
  end

  def make_coordinates
    coordinates = []
    range = "A".."D"
    range_letters = range.to_a
    range = 1..4
    range_numbers =  range.to_a

    range_letters.each do |letter|
      range_numbers.each do |number|
        coordinates << letter + number.to_s
      end
    end
    coordinates 
  end

  def make_cells
    cells = {}
    coordinates = make_coordinates
    coordinates.each do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end
    cells   
  end

  def valid_coordinate?(coordinate)
    cells.key?(coordinate)
  end

end