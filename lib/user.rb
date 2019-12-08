require_relative './board'
require_relative './ship'

class User

  attr_reader :type, :name, :turns, :ships
  attr_accessor :board

  def initialize(name, type)
    @name = name
    @type = type
    @board = Board.new
    @ships = {}
    @turns = []
  end

  def place_ship(ship, coordinates)
    if @board.valid_placement?(ship, coordinates)
      @ships[ship] = coordinates
      @board.place(ship, coordinates)
    end
  end

  def fire_at_coordinate(coordinate)
    if @board.valid_coordinate?(coordinate)
      @board.cells[coordinate].fire_upon
      @turns << coordinate
    end
  end

end