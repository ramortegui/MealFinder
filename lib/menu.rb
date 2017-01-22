##
# Represent a meal offered by a Restaurant, and required by OrderMenu.
class Menu
  ## Name of the Menu
  attr_reader :name

  ## Avaiable/Required quantities
  attr_reader :quantity

  ##
  # Receive two string defining the name and the quantity.
  def initialize(name, quantity)
    @name = name
    @quantity = quantity
  end

  ##
  # Remove a quanitty.
  def remove_qty(quantity)
    @quantity -= quantity
  end
end
