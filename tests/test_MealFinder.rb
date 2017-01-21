require "./lib/MealFinder.rb"
require 'minitest/autorun'


class TestMealFinder < MiniTest::Unit::TestCase

  def test_load_meal_finder
    m = MealFinder.new
    assert_equal(MealFinder,m.class)
  end
  
end
