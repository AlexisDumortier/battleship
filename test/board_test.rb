require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'
require_relative '../lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_is_a_hash_with_16_keys_pointing_to_cells_objects
    board = Board.new
    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.size
    board.cells.values.each do |value|
    assert_instance_of Cell, value
    end
  end

  def test_it_can_check_that_coordinates_are_valid
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_coordinates_in_array_should_be_same_length_as_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_coordinates_are_in_ascending_order
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
  end

  def test_coordinates_are_not_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_placement_is_valid_if_meets_previous_criteria
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_that_cell_receives_ship_after_ship_is_placed
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_cells_with_same_ship_have_the_same_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_4 = board.cells["A4"]

    assert_equal true, cell_3.ship == cell_2.ship
    assert_equal true, cell_2.ship == cell_1.ship
    assert_equal true, cell_1.ship == cell_3.ship
    assert_equal false, cell_4.ship == cell_2.ship
  end

  def test_ships_are_not_overlapping
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_board_renders_correctly
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    output1 = "  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"
    assert_equal output1, board.render
    output2 = "  1 2 3 4 \n" + "A S S S . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"
    assert_equal output2, board.render(true)
  end

end
