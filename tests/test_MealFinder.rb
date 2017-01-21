$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "restaurant.rb"
require "menu.rb"
require "order_menu.rb"
require "MealFinder.rb"
require 'minitest/autorun'


class TestMealFinder < MiniTest::Unit::TestCase

  def test_load_meal_finder
    m = MealFinder.new
    assert_equal(MealFinder,m.class)
  end

  def test_finder
    m = MealFinder.new
    
    r = Restaurant.new("A",5,40)
    r.addMenu(Menu.new("vegetarians",4))
    m.addRestaurant(r)

    r = Restaurant.new("B",3,100)
    r.addMenu(Menu.new("vegetarians",20))
    r.addMenu(Menu.new("gluten free",20))
    m.addRestaurant(r)

    om = OrderMenu.new(50)
    om.addMenu(Menu.new("vegetarians",5))
    om.addMenu(Menu.new("gluten free",7))

    res =  m.finder(om)

    assert_equal(res["A"]["vegetarians"],4)
    assert_equal(res["A"]["other"],36)

    assert_equal(res["B"]["vegetarians"],1)
    assert_equal(res["B"]["gluten free"],7)
    assert_equal(res["B"]["other"],2)
  end

end
