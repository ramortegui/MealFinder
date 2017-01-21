class Menu
  attr_reader :name, :quantity
  def initialize(name, quantity)
    @name = name
    @quantity = quantity
  end

  def remove_qty(quantity)
    @quantity -= quantity
  end
end
