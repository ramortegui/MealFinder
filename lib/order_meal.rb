##
# Represent the requested meals
class OrderMeal
  ## Hash representing Meal objects by name
  attr_reader :meals
  def initialize(quantity)
    @meals = {}
    @meals["other"] = Meal.new("other", quantity)
  end

  ##
  # Add meal to the order
  def addMeal(meal)
    @meals[meal.name] = meal
    @meals["other"].remove_qty(meal.quantity)
  end
end
