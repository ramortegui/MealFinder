# Meal Finder

## Statement

We're ordering meals for a team lunch. Every member in the team needs one meal, some have dietary restrictions such as vegetarian, gluten free, nut free, and fish free. We have a list of restaurants which serve meals that satisfy some of these restrictions. Each restaurant has a rating, and a limited amount of meals in stock that they can make today. Implement an object oriented system with automated tests that can automatically produce the best possible meal orders with reasonable assumptions.

### Example:

Team needs: total 50 meals including 5 vegetarians and 7 gluten free.

Restaurants: Restaurant A has a rating of 5/5 and can serve 40 meals including 4 vegetarians,

Restaurant B has a rating of 3/5 and can serve 100 meals including 20 vegetarians, and 20 gluten free.

## Asumptions

- The rating of each restaurant is an integer.
- The restaurants has enought meals in order to satisfy the team needs.

## Use

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

