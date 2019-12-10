class User
  attr_reader :name, :type, :ships, :turns, :board
  def initialize(name, type)
    @name = name
    @type = type
    @ships = {}
    @turns = []
    @board = Board.new
  end

  def place_ship(boat, coordinates)
    if board.valid_placement?(boat, coordinates)
      @board.place(boat, coordinates)
      @ships[boat] = coordinates
    end
  end

  def choose_coordinate(coordinate)
  end

  def fire_at_coordinate(opponent_board, coordinate)
    if opponent_board.valid_coordinate?(coordinate)
      opponent_board.cells[coordinate].fire_upon
      turns << coordinate
    end
  end
end
