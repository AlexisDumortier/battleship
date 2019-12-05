require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'
require './lib/board'

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

  

end
