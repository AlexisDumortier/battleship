require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
system('clear')


input = 'start'
while input != 'exit'
  game = Game.new
  input = game.play
end
