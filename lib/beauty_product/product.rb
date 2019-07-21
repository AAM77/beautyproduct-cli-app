class BeautyProduct::Product

  attr_accessor :name, :brand, :description, :directions, :ingredients_array, :ingredients_string, :sale_price, :url

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end # initialize

  def self.all
    @@all
  end # all

  def self.create_ingredients_array
    self.all.each do |product|
      if !product.ingredients_string.nil?
        product.ingredients_array = product.ingredients_string.split(", ").collect { |ingredient| ingredient.strip }
      end # if !nil?
    end # do |product|
  end # ingredient

  # # Creates an ingredient object for each one and adds this product to its products list
  # def self.add_ingredients
  #   self.all.each do |product|
  #     if !product.ingredients_array.nil?
  #       product.ingredients_array.each do |ingredient|
  #         if !BeautyProduct::Ingredient.all.detect {|element| element.name == ingredient}
  #           new_ingredient = BeautyProduct::Ingredient.new(ingredient)
  #           new_ingredient.products << product
  #         else
  #           existing_ingredient = BeautyProduct::Ingredient.all.detect {|element| element.name == ingredient}
  #           existing_ingredient.products << product
  #         end # if detect ingredient
  #       end # each ingredient
  #     end # if !nil?
  #   end # each product
  # end # add_ingredient


  def add_ingredients
    unless self.ingredients_array.nil?
      self.ingredients_array.each do |ingredient|
        unless BeautyProduct::Ingredient.all.detect {|element| element.name == ingredient}
          new_ingredient = BeautyProduct::Ingredient.new(ingredient)
          new_ingredient.products << self
        else
          existing_ingredient = BeautyProduct::Ingredient.all.detect {|element| element.name == ingredient}
          existing_ingredient.products << self
        end ## inner unless
      end ## each
    end ## outer unless
  end ##  method

end # class Product
####################
##  END OF CLASS  ##
####################
