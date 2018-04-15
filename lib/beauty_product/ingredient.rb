class BeautyProduct::Ingredient
  attr_accessor :name
  attr_reader :product
  @@all = []
  @@names = []

  def initialize(ingredient)
    @name = ingredient
    @products = []
    @@all << self
    @@names << ingredient.downcase if !@@names.include?(ingredient)
  end # initialize

  def self.all
    @@all
  end # all

  def self.names
    @@names
  end # names

  def products
    @products
  end # products


end # class Ingredient
