class BeautyProduct::Brand

  attr_accessor :name, :url

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end # initialize

  def self.all
    @@all
  end # all

end # class Brand
def product_list(product_list)
  self.products = product_list.split(", ")
end # product


########################################
## METHODS I MIGHT NEED IN THE FUTURE ##
########################################

=begin

def self.product
  self.all.each do |brand|
    brand.products.each do |product|
      new_product = BeautyProduct::Product.new(product)
      new_product.brand << brand
     end # each product
   end # each brand
 end # product

 def products
   @products
 end # products

 def product_list(product_list)
   self.products = product_list.split(", ")
 end # product

=end
