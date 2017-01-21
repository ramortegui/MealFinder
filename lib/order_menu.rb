class OrderMenu
  attr_reader :menus
  def initialize(quantity)
    @menus = {}
    @menus["other"] = Menu.new("other", quantity)
  end

  def addMenu(menu)
    @menus[menu.name] = menu
    @menus["other"].remove_qty(menu.quantity)
  end
end
