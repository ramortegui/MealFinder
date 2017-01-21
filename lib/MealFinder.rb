class MealFinder
  attr_accessor :restaurants
  require 'set'

  def initialize()
    @restaurants = SortedSet.new
  end

  def addRestaurant(restaurant)
    @restaurants << restaurant
  end
end

class Restaurant
  attr_accessor :name,:rating
  include Comparable

  def initialize(name, rating)
    @name = name
    @rating = rating
    @menus = Hash.new
  end

 def <=>( other)
   @rating <=> other.rating
 end

  def addMenu(menu)
    @menus[menu.name] = menu
  end

end

class Menu
  attr_accessor :name, :quantity
  def initialize(name, quantity)
    @name = name
    @quantity = quantity
  end
end
