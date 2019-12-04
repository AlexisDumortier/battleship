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

end
