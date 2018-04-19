
class BeautyProduct::TestProduct

  attr_accessor :name, :brand, :description, :directions, :ingredients_array, :ingredients_string, :price, :url

  @@all = []

  def initialize(name = nil, url = nil)
    @name = name
    @url = url
    @@all << self
  end # initialize

  def self.fetch_product_details(product)
    product_name = product.css("h3.productGridTitle").text
    product_page_url = "https://www.cultbeauty.co.uk#{product.attribute("href").value}"[/[^#]+/] #=> removes the large piece of url starting with '#'' and everything after
    self.new(product_name, product_page_url)
  end # .fetch_product_details()

  def self.all
    @@all
  end # all

  def

  def self.create_ingredients_array
    self.all.each do |product|
      if !product.ingredients_string.nil?
        product.ingredients_array = product.ingredients_string.split(", ").collect { |ingredient| ingredient.strip }
      end
    end # do |product|
  end # ingredient

  ## Creates an ingredient object for each one and adds this product to its products list
  def self.add_ingredients
    self.all.each do |product|
      if !product.ingredients_array.nil?
        product.ingredients_array.each do |ingredient|
          if !BeautyProduct::Ingredient.all.detect {|element| element.name == ingredient}
            new_ingredient = BeautyProduct::Ingredient.new(ingredient)
            new_ingredient.products << product
          else
            existing_ingredient = BeautyProduct::Ingredient.all.detect {|element| element.name == ingredient}
            existing_ingredient.products << product
          end # if detect ingredient
        end # each ingredient
      end # if !nil?
    end # each product
  end # add_ingredient

end # class Product
