class BeautyProduct::Ingredient
  attr_accessor :name

  @@all = []

  def initialize(ingredient)
    @name = ingredient
    @@all << self
    @products = []
  end # initialize

  def self.all
    @@all
  end # all

  def products
    @products
  end # products


end # class BeautyProduct::Ingredient
