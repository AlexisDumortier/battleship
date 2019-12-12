require_relative '../test_helper' 
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'

class CellTest < Minitest::Test 

  def test_it_exists
    cell = Cell.new('B4')
    assert_instance_of Cell, cell 
  end
  
  def test_a_cell_has_a_coordinate
    cell = Cell.new('B4')
    assert_equal 'B4', cell.coordinate
  end

  def test_a_cell_has_no_ship_by_default
    cell = Cell.new('B4')
    assert_nil cell.ship
  end
  
  def test_empty_checks_presence_of_ship
    cell = Cell.new('B4')
    assert_equal true, cell.empty?
    cruiser = Ship.new('Cruiser', 3)
    cell.ship = cruiser
    refute cell.empty?
  end

  def test_it_responds_to_place_ship
    cell = Cell.new('B4')
    assert_respond_to cell, :place_ship
  end

  def test_it_has_a_ship_after_a_ship_is_placed
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    assert_nil cell.ship
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    refute cell.empty?
  end

  def test_the_cell_is_not_fired_upon_by_default
    cell = Cell.new('B4')
    refute cell.fired_upon?
  end

  def test_firing_upon_cell_once_decreases_health_of_ship_if_any
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    assert_equal 3, cell.ship.health
    cell.fire_upon
    assert_equal 2, cell.ship.health
    cell.fire_upon
    assert_equal 2, cell.ship.health
  end

  def test_it_renders_correctly
    cell_1 = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    assert_equal '.', cell_1.render # showing there is not ship on the cell
    cell_1.fire_upon
    assert_equal 'M', cell_1.render # showing it was fired upon but missed
    cell_2 = Cell.new('B4')
    cell_2.place_ship(cruiser)
    assert_equal 'S', cell_2.render(true) # showing a ship is on the cell if true passed as argument
    assert_equal '.', cell_2.render # showing a ship is on the cell
    cell_2.fire_upon
    assert_equal 'H', cell_2.render # showing the ship on the cell was hit
    cruiser.hit
    cruiser.hit
    assert_equal 'X', cell_2.render # showing the ship on the cell was sunk
  end

end

