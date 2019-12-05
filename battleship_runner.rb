require './lib/board'
require './lib/cell'
require './lib/ship'

system('clear')

game = Game.new
game.play(game.user_input)

# game class 
# attributes :
# - ships {name => type, ...}
# - board
# - turns
# - users (human, computer)
# 
# methods :
# - show menu
# - play
# - take_turn

def user_input 
  # User is shown the main menu where they can play or quit
  puts 'Welcome to BATTLESHIP'
  puts 'Enter p to play. Enter q to quit.'
  input = gets.chomp

  while input.lowercase != 'p' || input.lowercase != 'q'
    puts 'Please enter p to play and q to quit.'
    input = gets.chomp
  end
  return input 
end

def play(input)
  if input == 'q'
    return done 
  else 

    # setup the game [ make a new board, place computer ships, place user ships]
    # while computer_wins != true or human_wins != true
    #   take_turn [stores the moves]
    #   render
    # end
  end
end

def setup_game



# in the runner file 


# ship1 = ship(cruiser, 3)
# ship2 = ship(submarine, 2)


# Main Menu:


# Setup:

# Computer can place ships randomly in valid locations
# User can enter valid sequences to place both ships
# Entering invalid ship placements prompts user to enter valid placements

# pick random orientation for ship1
# pick random first coordinate for ship1 within the board / using orientation constraint
# place ship 1

# pick random orientation for ship2
# pick random first coordinate for ship2 
# while ship2.valid_placement not true
#   pick random first coordinate for ship2 within the board / using orientation constraint
#   check valid_placement
# end
# place ship 2





