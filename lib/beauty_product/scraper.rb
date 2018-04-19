class BeautyProduct::TestScraper

  def initialize
    #scrape_brand_page
    scrape_sale_index_page
    scrape_discount_products
    create_products
    BeautyProduct::Product.create_ingredients_array ## Not sure if I need this...
    BeautyProduct::Product.add_ingredients
  end # initialize

  ## Scrapes the sale page
  def get_sale_index_page
    cult_beauty_url = "https://www.cultbeauty.co.uk"
    Nokogiri::HTML(open("#{cult_beauty_url}/sale.html"))
  end # get_sale_index_page

  ## Scrapes the products
  def scrape_discount_products
    self.get_sale_index_page.css("div.productGrid a")
  end # scrape_discount_products

  def create_products
    self.scrape_discount_products.each do |product|
      BeautyProduct::TestProduct.fetch_product_details(product)
    end # do |product|
  end # create_products
end # class Scraper
###################
## END OF CLASS  ##
###################



=begin

## SAVING FOR IF I DECIDE TO ADD BRAND FUNCTIONALITY ##
## Scrapes the Brands page for all Brands & adds to the Brand class in brand.rb
def scrape_brand_page

  cult_beauty_url = "https://www.cultbeauty.co.uk"

  brand_page = Nokogiri::HTML(open("#{cult_beauty_url}/brands"))

  brands = brand_page.css("ul.brandsList div.letterGroup a")

  brands.each do |brand|
    new_brand = BeautyProduct::Brand.new(brand.text)
    new_brand.url = "#{cult_beauty_url}#{brand.attribute("href").value}"
  end # do |brand|
end # scrape_brands


=end





























=begin

def self.scrape_brand_page

  sephora_url = "https://www.sephora.com"
  cult_beauty_url = "https://www.cultbeauty.co.uk"
  cult_beauty_sale = "https://www.cultbeauty.co.uk/sale.html"

  doc = Nokogiri::HTML(open("#{cult_beauty_url}/brands"))

  brands = doc.css("ul.brandsList div.letterGroup a")

  brands.each do |brand|
    new_brand = BeautyProduct::Brand.new(brand.text)
    new_brand.url = "#{cult_beauty_url}#{brand.attribute("href").value}"
  end # do |brand|
end # scrape_brands

def self.scrape_brand_products_page
  cult_beauty_url = "https://www.cultbeauty.co.uk"

  BeautyProduct::Brand.all.each do |brand|
    brand_page = Nokogiri::HTML(open(brand.url))

    products = brand_page.css("div.productGrid a")
    products.each do |product|
      product_name = product.css("h3.productGridTitle").text
      product_page_url = "#{cult_beauty_url}#{product.attribute("href").value}"
      new_product = BeautyProduct::Product.new(product_name)
      new_product.url = product_page_url[/[^#]+/]
      new_product.brand = brand
    end # |product|
  end # |brand|
end # self.scrape_brand_products_page

def self.scrape_product_page
  BeautyProduct::Product.all.each do |product|
    product_page = Nokogiri::HTML(open(product.url))
    product_info = product_page.css(".productInfo.js-product-info ul li")

    #product_info = product_page.css(".productInfo.js-product-info ul li")
    regular_price = product_page.css("span.productPrice.js-product-price").text
    sale_price = product_page.css("span.productSpecialPrice.js-product-special-price").text

    if sale_price.nil?
      product.price = (regular_price.to_f * 1.43).round(2).to_s
    else
      product.price = (sale_price.to_f * 1.43).round(2).to_s
    end # if price

    product_info.each do |info|
      if info.css("div.itemHeader span").text == "Description"
        product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "How to use"
        product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "Full ingredients list"
        product.ingredients =  info.css("div.itemContent").collect {|p| p.text}.join(" ")
      end # |if|
    end # |info|
  end # |product|
end # self.scrape_product_page



def self.scrape_sale_product
  BeautyProduct::Product.all.each do |product|
    product_page = Nokogiri::HTML(open(product.url))
    product_info = product_page.css(".productInfo.js-product-info ul li")

    #product_info = product_page.css(".productInfo.js-product-info ul li")
    product.price = (product_page.css("span.productSpecialPrice.js-product-special-price").text.to_f * 1.43).round(2).to_s

    product_info.each do |info|
      if info.css("div.itemHeader span").text == "Description"
        product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "How to use"
        product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "Full ingredients list"
        product.ingredients =  info.css("div.itemContent").collect {|p| p.text}.join(" ")
      end # |if|
    end # |info|
  end # |product|
end # self.scrape_product_page

=end






#################
# PREVIOUS CODE #
#################
=begin
class BeautyProduct::Scraper

  def initialize
    #scrape_brand_page
    scrape_sale_page
    scrape_product_page
    BeautyProduct::Product.create_ingredients_array ## Not sure if I need this...
    BeautyProduct::Product.add_ingredients
  end # initialize

  ## Scrapes the Sales Page
  ## Stores the product url
  def scrape_sale_page
    cult_beauty_url = "https://www.cultbeauty.co.uk"
    sale_page = Nokogiri::HTML(open("#{cult_beauty_url}/sale.html"))

    products = sale_page.css("div.productGrid a")
    products.each do |product|
      product_name = product.css("h3.productGridTitle").text
      product_page_url = "#{cult_beauty_url}#{product.attribute("href").value}"
      new_product = BeautyProduct::Product.new(product_name)
      new_product.url = product_page_url[/[^#]+/]  #=> removes the large piece of url starting with '#'' and everything after
    end # |product|
  end # scrape_sale_page

  ## Note: This could have been simpler.
  ## Left as is in case I want to add more functionality in the future.
  def scrape_product_page
    BeautyProduct::Product.all.each do |product|
      product_page = Nokogiri::HTML(open(product.url))

      product.brand = product_page.css("h1 a div.productBrandTitle").text ## Would be better if I associated with product.brand.name,
                                                                          ## but I am leaving it as is for sake of simplicity

      ## GETS PRICE & CONVERTS IT FROM POUNDS to USD ##
      regular_price = product_page.css("span.productPrice.js-product-price").text
      sale_price = product_page.css("span.productSpecialPrice.js-product-special-price").text

      if sale_price.nil?
        product.price = (regular_price.to_f * 1.43).round(2).to_s
      else
        product.price = (sale_price.to_f * 1.43).round(2).to_s
      end # if price


      ## SET PRODUCT DESCRIPTION, DIRECTIONS, & INGREDIENTS ##
      product_info = product_page.css(".productInfo.js-product-info ul li")
      product_info.each do |info|
        if info.css("div.itemHeader span").text == "Description"
          product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
        elsif info.css("div.itemHeader span").text == "How to use"
          product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
        elsif info.css("div.itemHeader span").text == "Full ingredients list"
          product.ingredients_string = info.css("div.itemContent").collect {|p| p.text}.join(" ")
        end # if css().text == 'Description', 'How to use', 'Full Ingredients list'
      end # do |info|
    end # do |product|
  end # scrape_product_page
end # class Scraper
###################
## END OF CLASS  ##
###################



=begin

## SAVING FOR IF I DECIDE TO ADD BRAND FUNCTIONALITY ##
## Scrapes the Brands page for all Brands & adds to the Brand class in brand.rb
def scrape_brand_page

  cult_beauty_url = "https://www.cultbeauty.co.uk"

  brand_page = Nokogiri::HTML(open("#{cult_beauty_url}/brands"))

  brands = brand_page.css("ul.brandsList div.letterGroup a")

  brands.each do |brand|
    new_brand = BeautyProduct::Brand.new(brand.text)
    new_brand.url = "#{cult_beauty_url}#{brand.attribute("href").value}"
  end # do |brand|
end # scrape_brands


=end





























=begin

def self.scrape_brand_page

  sephora_url = "https://www.sephora.com"
  cult_beauty_url = "https://www.cultbeauty.co.uk"
  cult_beauty_sale = "https://www.cultbeauty.co.uk/sale.html"

  doc = Nokogiri::HTML(open("#{cult_beauty_url}/brands"))

  brands = doc.css("ul.brandsList div.letterGroup a")

  brands.each do |brand|
    new_brand = BeautyProduct::Brand.new(brand.text)
    new_brand.url = "#{cult_beauty_url}#{brand.attribute("href").value}"
  end # do |brand|
end # scrape_brands

def self.scrape_brand_products_page
  cult_beauty_url = "https://www.cultbeauty.co.uk"

  BeautyProduct::Brand.all.each do |brand|
    brand_page = Nokogiri::HTML(open(brand.url))

    products = brand_page.css("div.productGrid a")
    products.each do |product|
      product_name = product.css("h3.productGridTitle").text
      product_page_url = "#{cult_beauty_url}#{product.attribute("href").value}"
      new_product = BeautyProduct::Product.new(product_name)
      new_product.url = product_page_url[/[^#]+/]
      new_product.brand = brand
    end # |product|
  end # |brand|
end # self.scrape_brand_products_page

def self.scrape_product_page
  BeautyProduct::Product.all.each do |product|
    product_page = Nokogiri::HTML(open(product.url))
    product_info = product_page.css(".productInfo.js-product-info ul li")

    #product_info = product_page.css(".productInfo.js-product-info ul li")
    regular_price = product_page.css("span.productPrice.js-product-price").text
    sale_price = product_page.css("span.productSpecialPrice.js-product-special-price").text

    if sale_price.nil?
      product.price = (regular_price.to_f * 1.43).round(2).to_s
    else
      product.price = (sale_price.to_f * 1.43).round(2).to_s
    end # if price

    product_info.each do |info|
      if info.css("div.itemHeader span").text == "Description"
        product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "How to use"
        product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "Full ingredients list"
        product.ingredients =  info.css("div.itemContent").collect {|p| p.text}.join(" ")
      end # |if|
    end # |info|
  end # |product|
end # self.scrape_product_page



def self.scrape_sale_product
  BeautyProduct::Product.all.each do |product|
    product_page = Nokogiri::HTML(open(product.url))
    product_info = product_page.css(".productInfo.js-product-info ul li")

    #product_info = product_page.css(".productInfo.js-product-info ul li")
    product.price = (product_page.css("span.productSpecialPrice.js-product-special-price").text.to_f * 1.43).round(2).to_s

    product_info.each do |info|
      if info.css("div.itemHeader span").text == "Description"
        product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "How to use"
        product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
      elsif info.css("div.itemHeader span").text == "Full ingredients list"
        product.ingredients =  info.css("div.itemContent").collect {|p| p.text}.join(" ")
      end # |if|
    end # |info|
  end # |product|
end # self.scrape_product_page

=end
