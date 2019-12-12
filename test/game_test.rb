require_relative '../test_helper' 
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'
require './lib/board'
require './lib/game'
require './lib/user'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game 
  end

  def test_it_has_attributes
    assert_equal Hash.new , @game.ship
    assert_equal Hash.new , @game.users
  end

  def test_it_can_add_up_to_two_users
    user1 = User.new('Bob', :human)
    user2 = User.new('Sam', :computer)
    user3 = User.new('Mat', :human)
    @game.add_user(user1)
    hash1 = {human: user1}
    assert_equal hash1 , @game.users
    @game.add_user(user2)
    hash2 = {human: user1, computer: user2}
    assert_equal hash2, @game.users
    hash2 = {human: user1, computer: user2}
    @game.add_user(user3)
    assert_equal hash2, @game.users
  end

end

