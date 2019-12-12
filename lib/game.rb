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
    @winner = nil
  end

  def play
    input = game_intro
    if input != 'q'
      setup
      while @winner == nil
          take_turn
          display_boards
      end
      system('clear')
    else
      puts "Ok, let's play another time"
      return 'exit'
    end
    return 'continue'
  end

  def game_intro
    # User is shown the main menu where they can play or quit
    puts "Welcome to BATTLESHIP \n\n"
    puts 'Enter p to play. Enter q to quit.'
    input = gets.chomp
    while (input.downcase != 'p') && (input.downcase != 'q')
      puts 'Please enter p to play and q to quit.'
      input = gets.chomp
    end
    return input
  end

  def user_choose_board_size
    width = user_choose_board_width
    length = user_choose_board_length
    [width, length]
  end

  def user_choose_board_width
    puts "Please enter the width of the board:"
    input = gets.chomp.strip.to_i
    while input == 0 || input > 26
      puts "Please enter the width of the board:"
      input = gets.chomp.strip.to_i
    end
    input
  end

  def user_choose_board_length
    puts "Please enter the length of the board (maximum length is 10):"
    input = gets.chomp.strip.to_i
    while input == 0 || input > 10
      puts "Please enter the length of the board (maximum length is 10):"
      input = gets.chomp.strip.to_i
    end
    input
  end

  def setup
    show_starting_game
    board_size = user_choose_board_size
    user1 = User.new('George', :human, board_size)
    add_user(user1)
    user2 = User.new('HAL', :computer, board_size)
    add_user(user2)
    ship_placement_computer
    puts "'I have laid out my ships on the grid... \n'You now need to lay out your two ships.' \n"
    puts "'The Cruiser is three units long and the Submarine is two units long.' \n \n"
    puts @users[:computer].board.render(true) + "\n"
    ship_placement_human
    display_boards
  end

  def show_starting_game
    system('clear')
    puts "========================================\n"
    puts ' >>>>>>>>>>> STARTING GAME  >>>>>>>>>>> '
    puts "========================================\n\n"
    sleep(2)
    system('clear')
  end

  def add_user(user)
    if @users.size < 2
      @users[user.type] = user
    else
      "cannot add more players"
    end
  end

  def display_boards
    system('clear')
    puts "=============COMPUTER BOARD=============\n\n"
    puts @users[:computer].board.render(false) + "\n"
    puts "==============PLAYER BOARD==============\n\n"
    puts @users[:human].board.render(true) + "\n"
  end

  def ship_placement_human
    ships = [["Cruiser", 3], ["Submarine", 2]]
    ships.each do |ship_info|
      boat = Ship.new(ship_info[0], ship_info[1])
      input = ship_placement_input(ship_info, boat)
      @users[:human].place_ship(boat, input.split(' '))
      system('clear')
      puts @users[:human].board.render(true) + "\n"
    end
  end

  def ship_placement_input(ship_info, ship)
    puts "Enter the squares for the #{ship_info[0]} (#{ship_info[1]} spaces):"
    input = gets.chomp.upcase.strip
    while !@users[:human].board.valid_placement?(ship, input.split(' '))
      puts 'Those are invalid coordinates. Please try again:'
      input = gets.chomp.upcase.strip
    end
    input
  end

  def ship_placement_computer
    ships = [["Cruiser", 3], ["Submarine", 2]]
    ships.each do |ship|
      boat = Ship.new(ship[0], ship[1])
      coordinates = @users[:computer].board.random_coordinate_generator(ship[1])
      while !@users[:computer].board.valid_placement?(boat, coordinates)
        coordinates = @users[:computer].board.random_coordinate_generator(ship[1])
      end
      @users[:computer].place_ship(boat, coordinates)
    end
  end

  def take_turn
    # coordinate = (@current_next[0] == :human ? take_turn_human : take_turn_computer)
    if @current_next[0] == :human
      coordinate = take_turn_human
    else
      coordinate = take_turn_computer
    end
    @users[@current_next[0]].fire_at_coordinate(@users[@current_next[1]].board, coordinate)
    print_results(coordinate)
    sleep(5)
    check_winner
    @current_next.reverse!
  end

  def take_turn_human
    puts 'Enter the coordinate for your shot:'
      coordinate = gets.chomp.upcase.strip
      while !@users[:human].board.valid_coordinate?(coordinate.upcase) || @users[:human].turns.include?(coordinate)
        puts "This coordinate has already been entered.\n" if @users[:human].turns.include?(coordinate)
        puts 'Please enter a valid coordinate:'
        coordinate = gets.chomp.upcase.strip
      end
      coordinate
  end

  def take_turn_computer
    shot_coordinate = @users[:computer].board.coordinates
    coordinate = shot_coordinate.sample
    while @users[:computer].turns.include?(coordinate)
      coordinate = shot_coordinate.sample
      # coordinate = shot_coordinate[rand(shot_coordinate.size)-1]
    end
    coordinate
  end

  def check_winner
    @users[@current_next[1]].ships.each do |ship|
      return false if !ship[0].sunk?
    end
    @winner = @users[@current_next[0]]
    announce_winner
  end

  def announce_winner
    puts "========================================"
    if @winner.type == :human
      puts "!!!!!!!!!!!!!!! YOU WON !!!!!!!!!!!!!! \n"
    else
      puts "!!!!!!!!!!!!!!! I WON !!!!!!!!!!!!!!!! \n"
    end
    puts "========================================"
    sleep(4)
  end

  def print_results(coordinate)
    system('clear')
    display_boards
    first_word = @current_next[0] == :human ? 'Your' : 'My'
    second_word = @current_next[0] == :human ? 'my' : 'your'
    if @users[@current_next[1]].board.cells[coordinate].empty?
      puts "#{first_word} shot on #{coordinate} missed."
    elsif !@users[@current_next[1]].board.cells[coordinate].ship.sunk?
      puts "#{first_word} shot on #{coordinate} hit #{second_word} ship."
    else
      puts "#{first_word} shot on #{coordinate} sunk #{second_word} ship!"
    end
  end

end
