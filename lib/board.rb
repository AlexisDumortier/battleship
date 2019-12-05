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

  def valid_placement?(ship, coordinates)
    coordinates.each do |coordinate|
      cell = cells[coordinate]
      return false if cell.empty? == false
    end
    return true if (ship.length == coordinates.length) && (consecutive_coordinates?(coordinates))
    false
  end

  def consecutive_coordinates?(coordinates)
    letter = []
    number = []
    coordinates.each do |coordinate|
      letter << coordinate[0]
      number << coordinate[1..-1].to_i
    end
    range1 = number[0]..(number[0] + number.length - 1)
    ascend_numbers = range1.to_a
    range2 = letter[0]..letter[-1]
    ascend_letters = range2.to_a
    return true if (letter.uniq.size == 1) && (number == ascend_numbers)

    return true if (number.uniq.size == 1) && (letter == ascend_letters)

    false
  end

  def place(boat, coordinates)
    coordinates.each do |coordinate|
      cell = cells[coordinate]
      cell.ship = boat
    end
  end


end
