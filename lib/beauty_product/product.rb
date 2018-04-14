
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
    hair_gel = self.new
    hair_gel.name = "Hair gel"
    hair_gel.price = "$5.00"
    hair_gel.ingredients = "glue, fragrance"
  end # hairgel

  def self.products
    product_1 = self.new
    product_1.name = "Perfect Hair Day Conditioner Mini"
    product_1.price = "$11.00"
    product_1.ingredients = "Magnesium Nitrate, Magnesium Chloride."

    product_2 = self.new
    product_2.name = "Restore Conditioner Mini"
    product_2.price = "$13.00"
    product_2.ingredients = "Behenyl Alcohol, Laureth-16"

    [product_1, product_2]
  end # product

  def ingredient
    products.each do |product|
      product.ingredients.each do |ingredient|
        ingredient.products << self
      end # each ingredient
    end # each product
  end # ingredient


end # class BeautyProduct::Product
