
class BeautyProduct::Product

  attr_accessor :name, :price, :ingredient, :ingredients, :directions, :description

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @ingredients = []
  end # initialize

  def self.all
    @@all
  end # all

  def ingredients
    @ingredients
  end # ingredients

  def ingredient_list(ingredient_list)
    self.ingredients = ingredient_list.split(", ")
  end # ingredient

  def self.products


  end # product

  def self.ingredient
    self.all.each do |product|
      product.ingredients.each do |ingredient|
        new_ingredient = BeautyProduct::Ingredient.new(ingredient)
        new_ingredient.products << product
       end # each ingredient
     end # each product
   end # ingredient

end # class Product
