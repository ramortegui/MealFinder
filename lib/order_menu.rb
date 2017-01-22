##
# Represent the requested meals
class OrderMenu
  ## Hash representing the Menu by name
  attr_reader :menus
  def initialize(quantity)
    @menus = {}
    @menus["other"] = Menu.new("other", quantity)
  end

  ##
  # Add menu to the order
  def addMenu(menu)
    @menus[menu.name] = menu
    @menus["other"].remove_qty(menu.quantity)
  end
end
