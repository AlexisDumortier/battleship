 class Cell
   attr_reader :coordinate
   attr_accessor :fired_upon, :ship
   def initialize(coordinate)
     @coordinate = coordinate
     @ship = nil
     @fired_upon = false
   end

   def empty?
     @ship == nil
   end

   def place_ship(ship)
     @ship = ship
   end

   def fired_upon?
     @fired_upon
   end

   def fire_upon
     @fired_upon = true
     unless empty?
       @ship.hit
     end
   end

   def render(showing = false)
    return "." if fired_upon? == false && empty? == true
    return "M" if fired_upon? == true && empty? == true
    return "S" if showing == true && empty? == false
    return "X" if ship.sunk? == true && empty? == false
    return "H" if fired_upon? == true && empty? == false
  end
 end
