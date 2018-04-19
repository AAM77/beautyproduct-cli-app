
class BeautyProduct::Product

  attr_accessor :name, :brand, :description, :directions, :ingredients_array, :ingredients_string, :price, :url

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

=begin
class BeautyProduct::Product

  attr_accessor :name, :brand, :description, :directions, :ingredients_array, :ingredients_string, :retail_price, :discount_price, :url

  @@all = []

  def initialize(name = nil, url = nil)
    @name = name
    @url = url
    @@all << self

    self.doc
    self.brand
    self.discount_price
    self.retail_price
    self.product_info
  end # initialize

  def self.fetch_product_details(product)
    product_name = product.css("h3.productGridTitle").text
    product_page_url = "https://www.cultbeauty.co.uk#{product.attribute("href").value}"[/[^#]+/] #=> removes the large piece of url starting with '#'' and everything after

    self.new(product_name, product_page_url)
  end # .fetch_product_details()

  def self.all
    @@all
  end # all

  def doc
    @doc = Nokogiri::HTML(open(self.url))
  end # doc

  def brand
    @brand = doc.css("h1 a div.productBrandTitle").text
  end # brand

  def retail_price
    @retail_price = doc.css("span.productPrice.js-product-price").text
  end # .retail_price

  def discount_price
    @discount_price = doc.css("span.productSpecialPrice.js-product-special-price").text
  end # .discount_price

  def convert_price(price)
    us_dollars = (price.to_f * 1.43).round(2).to_s
    us_dollars
  end # convert_price

  def product_info
     product_info = doc.css(".productInfo.js-product-info ul li")
     product_info.each do |info|
       if info.css("div.itemHeader span").text == "Description"
         self.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
       elsif info.css("div.itemHeader span").text == "How to use"
         self.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
       elsif info.css("div.itemHeader span").text == "Full ingredients list"
         self.ingredients_string = info.css("div.itemContent").collect {|p| p.text}.join(" ")
       end # if css().text == 'Description', 'How to use', 'Full Ingredients list'
     end # do |info|
  end # product_info


 ## THE FOLLOWING NEEDS MAJOR REFACTORING !!
  def self.create_ingredients_array
    self.all.each do |product|
      if !self.ingredients_string.nil?
        self.ingredients_array = self.ingredients_string.split(", ").collect { |ingredient| ingredient.strip }
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
=end
