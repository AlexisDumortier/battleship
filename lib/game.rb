require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/user'

class Game

  attr_reader :ship, :users

  def initialize
    @ship = {}
    @users = Hash.new
    @current_next = [:computer, :human]
  end

  def add_user(user)
    if @users.empty?
      @users[:human] = user
    elsif @users.size == 1
      @users[:computer] = user
    else
      puts "cannot add more players"
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

  def setup
    puts "Please enter your name : \n"
    input = gets.chomp
    system('clear')
    # until input.is_a? string
    #   puts "Please enter your name : \n"
    #   input = gets.chomp
    # end
    user1 = User.new(input, :human)
    add_user(user1)
    user2 = User.new('HAL', :computer)
    add_user(user2)
    ship_placement_computer
    puts "I have laid out my ships on the grid. \n"
    puts "You now need to lay out your two ships. \n"
    puts "The Cruiser is three units long and the Submarine is two units long. \n"
    puts "\n"
    puts @users[:computer].board.render(true)
    puts "\n"
    ship_placement
    display_boards
  end

  def display_boards
    system('clear')
    puts "=============COMPUTER BOARD=============\n\n"
    puts @users[:computer].board.render(false) + "\n"
    puts "==============PLAYER BOARD==============\n\n"
    puts @users[:human].board.render(true) + "\n"
  end

  def ship_placement
    ships = [["Cruiser", 3], ["Submarine", 2]]
    ships.each do |ship|
      puts "Enter the squares for the #{ship[0]} (#{ship[1]} spaces):"
      input = gets.chomp
      boat = Ship.new(ship[0], ship[1])
      while !@users[:human].board.valid_placement?(boat, input.split)
        puts "Those are invalid coordinates. Please try again:"
        input = gets.chomp
      end
      @users[:human].place_ship(boat, input.split)
      system('clear')
      puts @users[:human].board.render(true) + "\n"
    end
  end

  def ship_placement_computer
    ships = [["Cruiser", 3], ["Submarine", 2]]
    ships.each do |ship|
      boat = Ship.new(ship[0], ship[1])
      coordinates = @users[:computer].board.random_coordinate_generator(rand(2), ship[1])
      while !@users[:computer].board.valid_placement?(boat, coordinates)
        coordinates = @users[:computer].board.random_coordinate_generator(rand(2), ship[1])
      end
      @users[:computer].place_ship(boat, coordinates)
    end
  end

  def take_turn
    if @current_next[0] == :human
      puts "Enter the coordinate for your shot:"
      coordinate = gets.chomp
      while !@users[:human].board.valid_coordinate?(coordinate)
        puts "Please enter a valid coordinate:"
        coordinate = gets.chomp
      end
    else
      coordinate = "B1" #computer shoots
    end
    @users[@current_next[0]].fire_at_coordinate(@users[@current_next[1]].board, coordinate)
    print_results(coordinate)
    @current_next.reverse!
  end

  def print_results(coordinate)
    temp1 = @current_next[0] == :human ? "Your" : "My"
    temp2 = @current_next[0] == :human ? "my" : "your"
    if @users[@current_next[1]].board.cells[coordinate].empty?
      puts "#{temp1} shot on #{coordinate} missed."
      sleep(5)
    elsif !@users[@current_next[1]].board.cells[coordinate].ship.sunk?
      puts "#{temp1} shot on #{coordinate} hit #{temp2} ship."
      sleep(5)
    else
      puts "#{temp1} shot on #{coordinate} sunk #{temp2} ship!"
      sleep(5)
    end
  end


end
