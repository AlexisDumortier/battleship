require  './lib/cell'

class Board

  attr_reader :cells, :coordinates

  def initialize(size = [4, 4])
    @size = size
    @coordinates = make_coordinates(ALPHABET[@size[0]], @size[1])
    @cells = make_cells
  end

  ALPHABET = Hash[(1..26).to_a.zip(('A'..'Z').to_a)]

  def make_coordinates(last_letter, last_num, first_letter = "A", first_num = 1)
    coordinates = []
    range_letters = (first_letter..last_letter).to_a
    range_numbers = (first_num..last_num).to_a
    range_letters.each do |letter|
      range_numbers.each do |number|
        coordinates << letter + number.to_s
      end
    end
    coordinates
  end

  def make_cells
     @coordinates.reduce({}) do |result, coordinate|
      result[coordinate] = Cell.new(coordinate)
      result
    end
  end

  def random_coordinate_generator(length_ship)
    board_letter_range = ('A'..ALPHABET[@size[0]]).to_a
    if rand(2) == 1
      random_vertical_coord(length_ship, board_letter_range)
    else
      random_horizontal_coord(length_ship, board_letter_range)
    end
  end

  def random_vertical_coord(length, letter_range)
      coord = make_coordinates(letter_range[@size[0]-length], @size[1])
      start = coord[rand(coord.size)-1]
      make_coordinates((start[0].ord + length - 1).chr, start[1].to_i, start[0] , start[1].to_i)
  end

  def random_horizontal_coord(length, letter_range)
      coord = make_coordinates(letter_range[@size[0]-1], @size[1]-length+1)
      start = coord[rand(coord.size)-1]
      make_coordinates(start[0], start[1].to_i+length-1, start[0] , start[1].to_i)
  end

  def valid_coordinate?(coordinate)
    cells.key?(coordinate)
  end

  def valid_set_of_coordinates?(coordinates)
    coordinates.each do |coordinate|
      return false if !valid_coordinate?(coordinate)
    end
    true
  end

  def valid_placement?(ship, coordinates)
    return false if !valid_set_of_coordinates?(coordinates)
    return true if (ship.length == coordinates.length) && \
    (consecutive_coordinates?(coordinates)) && (!overlapping?(coordinates))
    false
  end

  def consecutive_coordinates?(coordinates)
    letters_numbers = extract_info_coordinates(coordinates)
    ascend_numbers = (letters_numbers[1][0]..(letters_numbers[1][0] + letters_numbers[1].length - 1)).to_a
    ascend_letters = (letters_numbers[0][0]..letters_numbers[0][-1]).to_a
    return true if (letters_numbers[0].uniq.size == 1) && (letters_numbers[1] == ascend_numbers)
    return true if (letters_numbers[1].uniq.size == 1) && (letters_numbers[0] == ascend_letters)
    false
  end

  def extract_info_coordinates(coordinates)
    coordinate_letters = []
    coordinate_numbers = []
    coordinates.each do |coordinate|
      coordinate_letters << coordinate[0]
      coordinate_numbers << coordinate[1..-1].to_i
    end
    [coordinate_letters, coordinate_numbers]
  end

  def overlapping?(coordinates)
    coordinates.each do |coordinate|
     return true if !cells[coordinate].empty?
    end
    false
  end

  def place(boat, boat_coordinates)
    boat_coordinates.each do |coordinate|
      cells[coordinate].ship = boat
    end
  end

  def render(showing = false)
    board_letter_range = ('A'..ALPHABET[@size[0]]).to_a
    number_range = (1..@size[1]).to_a
    rendered_string = '  '
    number_range.each { |num| rendered_string += num.to_s + ' ' }
    count = 0
    @coordinates.each do |coordinate|
      if (count % @size[1]).zero?
        rendered_string += "\n" + board_letter_range[count/@size[1]] + ' '
      end
      count += 1
      rendered_string += cells[coordinate].render(showing) + ' '
    end
    rendered_string + "\n"
  end

end
