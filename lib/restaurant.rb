##
# Represent a restaurant
class Restaurant
  ## Name of the Restaurant
  attr_reader :name
  ## Rating of the Restaurant
  attr_reader :rating
  ## Total of menus available on the restaurant
  attr_reader :meals_qty
  ## Total of menus
  attr_reader :menus

  include Comparable

  ##
  # Receive the name, rating, and the quantity of meals.  
  # By default all the meas will be added as "other"
  def initialize(name, rating, meals_qty)
    @name = name
    @rating = rating
    @menus = Hash.new
    @menus["other"] = Menu.new("other", meals_qty)

  end

  ##
  # Add Menu to the restaurant.  The quantity will be 
  # substracted of the total menus.
  def addMenu(menu)
    @menus[menu.name] = menu
    @menus["other"].remove_qty(menu.quantity)
  end

  ##
  #  Implementation of the comparable method.  This is used
  #  to order the Restaurants by rating.
  def <=>( other)
   @rating <=> other.rating
  end

end

