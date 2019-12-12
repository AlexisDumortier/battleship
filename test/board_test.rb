require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'
require_relative '../lib/board'

class BoardTest < Minitest::Test

  def test_the_board_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_the_board_has_a_hash_with_16_keys_pointing_to_cells_objects
    board = Board.new
    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.size
    board.cells.values.each do |value|
    assert_instance_of Cell, value
    end
  end

  def test_the_size_of_the_board_can_change
    board = Board.new([6, 6])
    board.cells.values.each do |value|
    assert_instance_of Cell, value
    end
    assert_equal 36, board.cells.size
  end

  def test_the_board_can_make_coordinates
    board = Board.new
    coordinates = ['A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4']
    assert_equal coordinates, board.make_coordinates('B', 4, first_letter = "A", first_num = 1)
  end

  def test_coordinates_are_recognized_as_valid_when_within_the_board
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_ship_placement_is_not_valid_when_coordinates_array_and_the_ship_have_different_lengths
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_ship_placement_is_valid_when_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_ship_placement_is_not_valid_when_coordinates_are_not_in_ascending_order
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
  end

  def test_ship_placement_is_not_valid_when_coordinates_are_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_ship_placement_is_not_valid_when_it_would_cause_overlapping
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_ship_placement_is_valid_when_coordinates_are_consecutive_ascending_not_diagonal_and_not_overlapping
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_validity_of_a_set_of_coordinates
    board = Board.new
    assert_equal true, board.valid_set_of_coordinates?(['A1', 'A2', 'A3'])
    refute board.valid_set_of_coordinates?(['B4', 'B5'])
  end

  def test_ship_can_be_placed_on_board
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    cell1 = board.cells['A1']
    cell2 = board.cells['A2']
    cell3 = board.cells['A3']
    assert_equal cruiser, cell1.ship
    assert_equal cruiser, cell2.ship
    assert_equal cruiser, cell3.ship
  end

  def test_cells_with_same_ship_have_the_same_ship
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    cell1 = board.cells['A1']
    cell2 = board.cells['A2']
    cell3 = board.cells['A3']
    cell4 = board.cells['A4']
    assert_equal true, cell3.ship == cell2.ship
    assert_equal true, cell2.ship == cell1.ship
    assert_equal true, cell1.ship == cell3.ship
    assert_equal false, cell4.ship == cell2.ship
  end

  def test_board_renders_correctly
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    output1 = "  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"
    assert_equal output1, board.render
    board.place(cruiser, ['A1', 'A2', 'A3'])
    assert_equal output1, board.render
    output2 = "  1 2 3 4 \n" + "A S S S . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"
    assert_equal output2, board.render(true)
  end

  def test_extract_info_coordinates
    board = Board.new
    coordinates = ['A1', 'B1', 'C1']
    assert_equal [['A', 'B', 'C'], [1, 1, 1]], board.extract_info_coordinates(coordinates)
  end

  def test_random_vertical_coord_produces_vertical_and_consecutive_coordinates
     board = Board.new
     board_letter_range = ('A'..'D').to_a
     coord = board.random_vertical_coord(3, board_letter_range)
     info = board.extract_info_coordinates(coord)
     assert_equal 1, info[1].uniq.size
     assert_equal true, board.consecutive_coordinates?(coord)
  end

  def test_random_horizontal_coord_produces_horiztontal_and_consecutive_coordinates
    board = Board.new
    board_letter_range = ('A'..'D').to_a
    coord = board.random_horizontal_coord(3, board_letter_range)
    info = board.extract_info_coordinates(coord)
    assert_equal 1, info[0].uniq.size
    assert_equal true, board.consecutive_coordinates?(coord)
  end

  def test_the_overlapping_method_detects_ship_presence_for_a_given_coordinate
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.overlapping?(['A1'])
    board.place(cruiser, ['A1', 'A2', 'A3'])
    assert_equal true, board.overlapping?(['A1'])
  end

  def test_coordinates_can_be_tested_for_consecutiveness
    board = Board.new
    consecutive_coord = ['A1', 'B1', 'C1']
    not_consecutive_coord1 = ['A1', 'B2']
    not_consecutive_coord2 = ['B1', 'A1']
    not_consecutive_coord3 = ['B2', 'C4']
    refute board.consecutive_coordinates?(not_consecutive_coord1)
    refute board.consecutive_coordinates?(not_consecutive_coord2)
    refute board.consecutive_coordinates?(not_consecutive_coord3)
    assert_equal true, board.consecutive_coordinates?(consecutive_coord)

  end

end
