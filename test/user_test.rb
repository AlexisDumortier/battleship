require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/user'
require_relative '../lib/board'
require_relative '../lib/ship'


class UserTest < Minitest::Test 
  
  def test_it_exists
    user = User.new('Bob', :human)
    assert_instance_of User, user 
  end
  
  def test_it_has_attributes
    user = User.new('Bob', :human)
    assert_equal 'Bob', user.name
    assert_equal :human, user.type
    ships = {}
    assert_equal ships, user.ships 
  end
  
  def test_it_can_place_ship
    user = User.new('Bob', :human)
    cruiser = Ship.new('cruiser', 3)
    submarine = Ship.new('submarine', 2)
    ships1 = {}
    assert_equal ships1, user.ships 
    user.place_ship(cruiser, ['A1', 'A2', 'A3'])
    ships2 = {cruiser => ['A1', 'A2', 'A3']}
    assert_equal ships2, user.ships
    user.place_ship(submarine, ['A1', 'B1'])
    assert_equal ships2, user.ships
    user.place_ship(submarine, ['B1', 'C1'])
    ships3 = {cruiser => ['A1', 'A2', 'A3'], submarine => ['B1', 'C1']}
    assert_equal ships3, user.ships
  end

  def test_it_can_fire_at_coordinate
    user = User.new('Bob', :human)
    user.fire_at_coordinate('A2')
    assert_equal true, user.board.cells['A2'].fired_upon?
  end

end
