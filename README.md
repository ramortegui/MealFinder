# Meal Finder

## Statement

We're ordering meals for a team lunch. Every member in the team needs one meal, some have dietary restrictions such as vegetarian, gluten free, nut free, and fish free. We have a list of restaurants which serve meals that satisfy some of these restrictions. Each restaurant has a rating, and a limited amount of meals in stock that they can make today. Implement an object oriented system with automated tests that can automatically produce the best possible meal orders with reasonable assumptions.

### Example:

Team needs: total 50 meals including 5 vegetarians and 7 gluten free.

Restaurants: Restaurant A has a rating of 5/5 and can serve 40 meals including 4 vegetarians,

Restaurant B has a rating of 3/5 and can serve 100 meals including 20 vegetarians, and 20 gluten free.

Expected meal orders: Restaurant A (4 vegetarian + 36 others), Restaurant B (1 vegetarian + 7 gluten free + 2 others)

## Asumptions

- The user has ruby installed
- The rating of each restaurant is an integer.
- The total meals of the restaurants are enough to satisfy the team's order.

## How to run

clone the repository.

    $>git clone https://github.com/ramortegui/MealFinder.git

Change the directory

    $>cd MealFinder

Install the dependencies

    $>./bin/setup

Run tests

    $>rake tests

Run console

    $>./bin/console

### Using the structure (console)

    #Create a new meal finder
    m = MealFinder.new

    #Create and add a new restaurant
    r = Restaurant.new("A",5,40)
    r.addMenu(Menu.new("vegetarians",4))
    m.addRestaurant(r)

    #Create and add a new restaurant
    r = Restaurant.new("B",3,100)
    r.addMenu(Menu.new("vegetarians",20))
    r.addMenu(Menu.new("gluten free",20))
    m.addRestaurant(r)

    #Create an order
    om = OrderMenu.new(50)
    #Add special meals to the order
    om.addMenu(Menu.new("vegetarians",5))
    om.addMenu(Menu.new("gluten free",7))

    #Get the result
    res =  m.finder(om)
    => {"A"=>{"other"=>36, "vegetarians"=>4}, "B"=>{"other"=>2, "vegetarians"=>1, "gluten free"=>7}}

    #to print the result
    m.print_result(r)
    The result of the meal finder is:
    Restaurant: A
      other 36
      vegetarians 4
    Restaurant: B
      other 2
      vegetarians 1
      gluten free 7
      => nil



### Processing a file

The Module support json file definitions as:

#### Sample of data structure defined on: ./tests/data/problem.js
```
{
  "restaurants": [
    {
      "name": "A",
      "rating": 5,
      "meals_qty": 40,
      "specials": [
        { "vegetarians": 4  }
      ]
    },
    {
      "name": "B",
      "rating": 3,
      "meals_qty": 100,
      "specials":[
        { "vegetarians": 20 },
        { "gluten free": 20 }
      ]
    }
  ],
  "order": {
    "quantity": 50,
    "specials": [
      { "vegetarians": 5 },
      { "gluten free": 7 }
    ]
  }
}
```
#### Processing the file (console)

    #Create a MealFinder
    m = MealFinder.new

    #Process a json file
    res = m.process_file("tests/data/problem.js")
    => {"A"=>{"other"=>36, "vegetarians"=>4}, "B"=>{"other"=>2, "vegetarians"=>1, "gluten free"=>7}} 

    #to print the result
    m.print_result(r)
    The result of the meal finder is:
    Restaurant: A
      other 36
      vegetarians 4
    Restaurant: B
      other 2
      vegetarians 1
      gluten free 7
      => nil

