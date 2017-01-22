$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "restaurant.rb"
require "meal.rb"
require "order_meal.rb"
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
    r.addMeal(Meal.new("vegetarians",4))
    m.addRestaurant(r)

    r = Restaurant.new("B",3,100)
    r.addMeal(Meal.new("vegetarians",20))
    r.addMeal(Meal.new("gluten free",20))
    m.addRestaurant(r)

    om = OrderMeal.new(50)
    om.addMeal(Meal.new("vegetarians",5))
    om.addMeal(Meal.new("gluten free",7))

    res =  m.finder(om)

    assert_equal(res["A"]["vegetarians"],4)
    assert_equal(res["A"]["other"],36)

    assert_equal(res["B"]["vegetarians"],1)
    assert_equal(res["B"]["gluten free"],7)
    assert_equal(res["B"]["other"],2)
  end

  def test_process_file
    m = MealFinder.new
    res = m.process_file("tests/data/problem.js")
    
    assert_equal(res["A"]["vegetarians"],4)
    assert_equal(res["A"]["other"],36)

    assert_equal(res["B"]["vegetarians"],1)
    assert_equal(res["B"]["gluten free"],7)
    assert_equal(res["B"]["other"],2)
  end

  def test_process_file_restaurants_unordered
    m = MealFinder.new
    res = m.process_file("tests/data/problem_unordered.js")
    
    assert_equal(res["A"]["vegetarians"],4)
    assert_equal(res["A"]["other"],36)

    assert_equal(res["B"]["vegetarians"],1)
    assert_equal(res["B"]["gluten free"],7)
    assert_equal(res["B"]["other"],2)
  end

  def test_process_file_no_exists
    m = MealFinder.new

    res = m.process_file("tests/data/no-exists.js")

    assert_equal(res, nil)
  end

end
