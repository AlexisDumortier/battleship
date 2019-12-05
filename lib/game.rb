require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/user'

class Game

  attr_reader ship

  def initialize 
    @ship = {}
    @board = Board.new
    @users = Hash.new
    @turns = {}
  end

  def add_user(user)
    if @users.empty?
      @users[:user1] = user
    elsif @users.size == 1
      @users[:user2] = user
    end
  end


end