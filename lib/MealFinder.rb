class MealFinder
  require 'set'
  def initialize()
    @restaurants = SortedSet.new
  end

  def addRestaurant(restaurant)
    @restaurants << restaurant
  end

  #receive a hash with the requirements
  def finder(order_menu)
    result = {}
    menus = order_menu.menus
    @restaurants.reverse_each do |restaurant|
      restaurant_temp = restaurant
      menus.keys.each do |name|
        if ( restaurant.menus[name] && restaurant_temp.menus[name].quantity > 0 )
          if ( menus[name].quantity <= restaurant_temp.menus[name].quantity ) 
            result[restaurant_temp.name] = {} unless result[restaurant_temp.name]
            result[restaurant_temp.name][name] = menus[name].quantity
            restaurant_temp.menus[name].remove_qty(menus[name].quantity)
          else
            result[restaurant_temp.name] = {} unless result[restaurant_temp.name]
            result[restaurant_temp.name][name] = restaurant_temp.menus[name].quantity
            menus[name].remove_qty(restaurant_temp.menus[name].quantity)
          end
        end
      end
    end
    result
  end
end
