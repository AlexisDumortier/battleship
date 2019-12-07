require  './lib/cell'

class Board

  attr_reader :cells

  def initialize
    @coordinates = make_coordinates
    @cells = make_cells
    @size = [ 4, 4 ]
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
    @coordinates.each do |coordinate|
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

  def place(boat, boat_coordinates)
    boat_coordinates.each do |coordinate|
      cell = cells[coordinate]
      cell.ship = boat
    end
  end

  def render(showing = false)
    number_range = (1..@size[0]).to_a 
    alphabet = Hash[(1..26).to_a.zip(('A'..'Z').to_a)]
    letter_range = ('A'..alphabet[@size[1]]).to_a
    rendered_string = '  '
    number_range.each { |num| rendered_string += num.to_s + ' ' }
    count = 0
    @coordinates.each do |coordinate|
      if (count % @size[1]).zero? 
        rendered_string += "\n" + letter_range[count/@size[1]] + ' '
      end 
      count += 1
      rendered_string += cells[coordinate].render(showing) + ' '
    end
    rendered_string + "\n"
  end
end