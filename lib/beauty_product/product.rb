
class BeautyProduct::Product

  attr_accessor :name, :price, :ingredients

  @@all = []

  def initialize
    @@all << self
  end # initialize

  def self.all
    @@all
  end # all

  def self.hairgel


  end # hairgel

  def self.products
    product_1 = self.new
    product_1.name = "Lipstick"
    product_1.price = "$11.00"
    product_1.ingredients = "Magnesium Nitrate, Magnesium Chloride, fragrance"

    product_2 = self.new
    product_2.name = "Eye liner"
    product_2.price = "$13.00"
    product_2.ingredients = "Behenyl Alcohol, Laureth-16, glue"

    hair_gel = self.new
    hair_gel.name = "Hair gel"
    hair_gel.price = "$5.00"
    hair_gel.ingredients = "glue, fragrance"
  end # product

  def self.ingredient
    self.all.each do |product|
      product.ingredients.split(", ").each do |ingredient|
        new_ingredient = BeautyProduct::Ingredient.new(ingredient)
        new_ingredient.products << product
      end # each ingredient
    end # each product
  end # ingredient


end # class BeautyProduct::Product
