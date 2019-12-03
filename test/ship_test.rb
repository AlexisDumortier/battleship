require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/ship'

class ShipTest < Minitest::Test 

  def test_it_exists
    ship = Ship.new('Cruiser', 3)
    assert_instance_of Ship, ship 
  end

  def test_it_has_a_name
    ship = Ship.new('Cruiser', 3)
    assert_equal 'Cruiser', ship.name 
  end

  def test_it_has_a_length
    ship = Ship.new('Cruiser', 3)
    assert_equal 3, ship.length
  end

  def test_it_is_initialize_with_a_heatlh_equal_to_its_length
    ship = Ship.new('Cruiser', 3)
    assert_equal 3, ship.health
  end

  def test_its_health_is_decremented_every_time_it_gets_hit
    ship = Ship.new('Cruiser', 3)
    assert_equal 3, ship.health
    ship.hit
    assert_equal 2, ship.health
    ship.hit
    assert_equal 1, ship.health
    ship.hit
    assert_equal 0, ship.health
  end

  def test_it_returns_true_to_sunk_when_health_is_zero
    ship = Ship.new('Cruiser', 3)
    assert_equal 3, ship.health
    refute ship.sunk?
    ship.hit
    assert_equal 2, ship.health
    refute ship.sunk?
    ship.hit
    assert_equal 1, ship.health
    refute ship.sunk?
    ship.hit
    assert_equal 0, ship.health
    assert ship.sunk?
  end

end
