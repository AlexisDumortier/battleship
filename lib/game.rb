require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/user'

class Game

  attr_reader :ship, :board, :users

  def initialize 
    @ship = {}
    @board = Board.new
    @users = Hash.new
  end

  def add_user(user)
    if @users.empty?
      @users[:user1] = user
    elsif @users.size == 1
      @users[:user2] = user
    else
      puts "can not add more players"
    end
  end

    def user_input 
    # User is shown the main menu where they can play or quit
    puts 'Welcome to BATTLESHIP'
    puts 'Enter p to play. Enter q to quit.'
    input = gets.chomp
    while (input.downcase != 'p') && (input.downcase != 'q')
      puts 'Please enter p to play and q to quit.'
      input = gets.chomp
    end
    return input 
  end

    def play(input)
      if input == 'q'
        return false 
      else 

        # setup the game [ make a new board, place computer ships, place user ships]
        # while computer_wins != true or human_wins != true
        #   take_turn [stores the moves]
        #   render
        # end
      end
  end

  def setup_game
    puts "Please enter your name : \n"
    input = gets.chomp
    
    # until input.is_a? string
    #   puts "Please enter your name : \n"
    #   input = gets.chomp
    # end  
    user1 = User.new(input, :human)
    add_user(user1)
    user2 = User.new('HAL', :computer)
    add_user(user2)
  end

  def display_boards
    puts "=============COMPUTER BOARD=============\n"
    @users[:user2].board.render 
    puts "==============PLAYER BOARD==============\n"
    @users[:user1].board.render 
  end

end