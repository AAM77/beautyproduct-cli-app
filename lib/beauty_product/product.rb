
class BeautyProduct::Product

  attr_accessor :name, :price, :ingredient, :ingredients

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
    product_1 = self.new("Lipstick")
    #product_1.name = "Lipstick"
    product_1.price = "$11.00"
    product_1.ingredient_list("Magnesium Nitrate, Magnesium Chloride, fragrance")
    #product_1.ingredients.each {|ingredient| add_ingredient(ingredient)}

    product_2 = self.new("Eye liner")
    #product_2.name = "Eye liner"
    product_2.price = "$13.00"
    product_2.ingredient_list("Behenyl Alcohol, Laureth-16, glue")

    hair_gel = self.new("Hair gel")
    #hair_gel.name = "Hair gel"
    hair_gel.price = "$5.00"
    hair_gel.ingredient_list("glue, fragrance")

  end # product

  def self.ingredient
    self.all.each do |product|
      product.ingredients.each do |ingredient|
        new_ingredient = BeautyProduct::Ingredient.new(ingredient)
        new_ingredient.products << product
       end # each ingredient
     end # each product
   end # ingredient




end # class BeautyProduct::Product
