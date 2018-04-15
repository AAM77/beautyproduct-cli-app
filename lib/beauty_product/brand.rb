class BeautyProduct::Brand

  attr_accessor :name, :price, :product, :products

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @products = []
  end # initialize

  def self.all
    @@all
  end # all

  def products
    @products
  end # products

  def product_list(product_list)
    self.products = product_list.split(", ")
  end # product

  def self.brand


  end # brand

  def self.product
    self.all.each do |brand|
      brand.products.each do |product|
        new_product = BeautyProduct::Product.new(product)
        new_product.brand << brand
       end # each product
     end # each brand
   end # product

end # class Product



end # class Brand
