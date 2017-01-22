##
# This class represents a MealFinder program
class MealFinder
  require 'set'
  require 'json'

  ##
  # Creates a new MealFinder with empty restaurants.
  # The restaurants attribute is SortedSet object that will
  # be filled by the MealFinder.addRestaurant method.
  def initialize()
    @restaurants = SortedSet.new
  end

  ##
  # Add a restaurant to the MealFinder.  This method receive 
  # an Restaurant Object
  def addRestaurant(restaurant)
    @restaurants << restaurant
  end

  ##
  # The MealFinder.finder method, receive an OrderMeal object and scann the 
  # restaurants ordered by rating.  It returns a Hash object with
  # the restaurants and the meals delivered in order to complete
  # the OrderMeal requirement.
  def finder(order_meal)
    result = Hash.new 
    meals = order_meal.meals
    @restaurants.reverse_each do |restaurant|
      restaurant_temp = restaurant
      meals.keys.each do |name|
        if ( restaurant.meals[name] && restaurant_temp.meals[name].quantity > 0 )
          if ( meals[name].quantity <= restaurant_temp.meals[name].quantity ) 
            result[restaurant_temp.name] = Hash.new unless result[restaurant_temp.name]
            result[restaurant_temp.name][name] = meals[name].quantity
            restaurant_temp.meals[name].remove_qty(meals[name].quantity)
          else
            result[restaurant_temp.name] = Hash.new unless result[restaurant_temp.name]
            result[restaurant_temp.name][name] = restaurant_temp.meals[name].quantity
            meals[name].remove_qty(restaurant_temp.meals[name].quantity)
          end
        end
      end
    end

    result
  end

  ##
  #  Receive the route of a file containing a valid json definition of the restaurants
  #  and the order.
  #
  #  The method parse the json file, and fill the restaurants of the MealFinder.  Also, 
  #  creates the OrderMeal, and process the file.
  #
  #  The result in case of success is a hash with the result of the MealFinder.finder method.
  def process_file(filename)
    structure = nil
    begin
      structure = JSON.parse( IO.read(filename, encoding:'utf-8') )
    rescue
        print "Error loading/parsing File: #{$!}"
        return nil
    end
    begin
      if( structure["restaurants"].count > 0 )
        structure["restaurants"].each do |r_data|
          if( r_data["name"] && r_data["rating"] && r_data["meals_qty"] )
            restaurant = Restaurant.new(r_data["name"],r_data["rating"],r_data["meals_qty"])
            if( r_data["specials"] )
              specials = r_data["specials"]
              specials.each do |special|
                special.keys.each do |key|
                  restaurant.addMeal(Meal.new( key, special[key] ))
                end
              end
            end
            addRestaurant(restaurant)
          else
            print "Restaurant #{r_data} doesn't have minimum data"
            return
          end
        end
        if( structure["order"] )
          if( structure["order"]["quantity"] )
            order_meal = OrderMeal.new(structure["order"]["quantity"])
            specials = structure["order"]["specials"]
            if( specials )
              specials.each do |special|
                special.keys.each do |key|
                  order_meal.addMeal(Meal.new( key, special[key]))
                end
              end
            end
            return finder(order_meal)
          else
            print "No quantity defined for order."
          end
        end
      else
        print "No restaurantsi defined";
        return
      end
    rescue
      print "Error trying to load structure on #{$!}"
    end
    return
  end

  ##
  # Receives a Hash with the result of the MealFinder.finder method and prints their
  # data.
  def print_result(result)
    puts "The result of the meal finder is: "
    result.keys.each do |restaurant|
      puts "Restaurant: #{restaurant}"
      result[restaurant].keys.each do |meal|
        puts "\t #{meal} #{result[restaurant][meal]}"
      end
    end
    return
  end

end
