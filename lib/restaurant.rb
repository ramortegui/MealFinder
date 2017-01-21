class Restaurant
  attr_reader :name,:rating,:meals_qty, :menus

  include Comparable

  def initialize(name, rating, meals_qty)
    @name = name
    @rating = rating
    @menus = Hash.new
    @menus["other"] = Menu.new("other", meals_qty)

  end

  def addMenu(menu)
    @menus[menu.name] = menu
    @menus["other"].remove_qty(menu.quantity)
  end

  def <=>( other)
   @rating <=> other.rating
  end

end

