##
# Represent a restaurant
class Restaurant
  ## Name of the Restaurant
  attr_reader :name
  ## Rating of the Restaurant
  attr_reader :rating
  ## Total of meals available on the restaurant
  attr_reader :meals_qty
  ## Total of meals
  attr_reader :meals

  include Comparable

  ##
  # Receive the name, rating, and the quantity of meals.  
  # By default all the meals will be added as "other"
  def initialize(name, rating, meals_qty)
    @name = name
    @rating = rating
    @meals = Hash.new
    @meals["other"] = Meal.new("other", meals_qty)

  end

  ##
  # Add Meal to the restaurant.  The quantity will be 
  # substracted of the total meals.
  def addMeal(meal)
    @meals[meal.name] = meal
    @meals["other"].remove_qty(meal.quantity)
  end

  ##
  #  Implementation of the comparable method.  This is used
  #  to order the Restaurants by rating.
  def <=>( other)
   @rating <=> other.rating
  end

end

