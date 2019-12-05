require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game 
  end

  def test_it_has_attributes
    assert_equal Hash.new , @game.ship
    assert_equal board , @game.board
    assert_equal [] , @game.turns
    assert_equal Hash.new() , @game.users
  end

  def test_it_can_add_users
    user1 = User.new(name1)
    user2 = User.new(name2)
    @game.add(user1)
    @game.add(user2)
    hash1 = {player1: user1}
    hash2 = {player1: user1, player2: user2}
    assert_equal hash1 , @game.users
    assert_equal hash2, @game.users
  end

end