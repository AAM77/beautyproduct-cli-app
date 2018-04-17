class BeautyProduct::Ingredient
  attr_accessor :name, :product
  @@all = []

  def initialize(ingredient)
    @name = ingredient
    @products = []
    @@all << self
  end # initialize

  def self.all
    @@all
  end # all

  def products
    @products
  end # products


end # class Ingredient
