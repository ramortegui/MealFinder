class MealFinder
  require 'set'
  require 'json'
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
                  restaurant.addMenu(Menu.new( key, special[key] ))
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
            order_menu = OrderMenu.new(structure["order"]["quantity"])
            specials = structure["order"]["specials"]
            if( specials )
              specials.each do |special|
                special.keys.each do |key|
                  order_menu.addMenu(Menu.new( key, special[key]))
                end
              end
            end
            finder(order_menu)
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

  end

  def print_result(result)
    puts "The result of the meal finder is: "
    result.keys.each do |restaurant|
      puts "Restaurant: #{restaurant}"
      result[restaurant].keys.each do |menu|
        puts "\t #{menu} #{result[restaurant][menu]}"
      end
    end
    return
  end

end
