# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "MealFinder"
  spec.version       = '1.0'
  spec.authors       = ["Ruben Amortegui"]
  spec.email         = ["ruben.amortegui@gmail.com"]
  spec.summary       = %q{Meal finder excercise}
  spec.description   = %q{This exercise is a sample of an object oriented design for a problem.}
  spec.license       = "MIT"

  spec.files         = ['lib/MealFinder.rb']
  spec.test_files    = ['tests/test_MealFinder.rb']
  spec.require_paths = ["lib"]
end
