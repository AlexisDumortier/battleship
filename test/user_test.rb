require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'
require_relative '../lib/board'
require_relative '../lib/user'

class UserTest < Minitest::Test
  def test_it_exists
    user = User.new('Terry', :human)
    assert_instance_of User, user
  end

  def test_it_has_attributes
    user = User.new('Terry', :human)
    assert_equal 'Terry', user.name
    returned_ships = {}
    assert_equal :human, user.type
    assert_equal returned_ships, user.ships
    assert_equal [], user.turns
    assert_instance_of Board, user.board
  end

  def test_it_stores_turns
    user = User.new('Terry', :human)
    opponent_board = Board.new
    user.fire_at_coordinate(opponent_board, 'B32')
    assert_equal [], user.turns
    user.fire_at_coordinate(opponent_board, 'A1')
    assert_equal ['A1'], user.turns
  end

  def test_it_can_place_a_ship
    user = User.new('Terry', :human)
    cruiser = Ship.new(:cruiser, 3)
    submarine = Ship.new(:submarine, 2)
    ships1 = {}
    ships2 = {cruiser => ['C1', 'C2', 'C3']}
    ships3 = {cruiser => ['C1', 'C2', 'C3'], submarine => ['A1', 'A2']}
    assert_equal ships1, user.ships
    user.place_ship(cruiser, ['D4', 'D3'])
    assert_equal ships1, user.ships
    user.place_ship(cruiser, ['C1', 'C2', 'C3'])
    assert_equal ships2, user.ships
    user.place_ship(submarine, ['C1', 'D1'])
    assert_equal ships2, user.ships
    user.place_ship(submarine, ['A1', 'A2'])
    assert_equal ships3, user.ships
    assert_equal submarine, user.board.cells['A1'].ship
    assert_equal submarine, user.board.cells['A2'].ship
  end

  def test_it_can_fire_at_coordinate
    user = User.new('Terry', :human)
    opponent_board = Board.new
    user.fire_at_coordinate(opponent_board, "A1")
    assert_equal true, opponent_board.cells['A1'].fired_upon?
  end
end
