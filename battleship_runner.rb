require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
system('clear')

game = Game.new
game.play(game.user_input)
game.setup_game
game.display_boards


# user class
# attributes :
# - ships   { cruiser => [], submarine => [] }
# - name
# - type (human or computer)
# - turns []
#
# methods :
# - place_ship(cruiser, ['A1', 'A2', 'A3'])
# - fire_at_coordinate('A1')
#.-.choose_coordinates

# in the runner file 

# def initialize(name, type)

# user1.choose_coordinates
# user2.choose_coordinates

# def choose_coordinates 
#   if type == human 
#     puts "enter the coordinates"
#     input = get.chomp
#   else
#     random(sjdflsj)

# end  


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





