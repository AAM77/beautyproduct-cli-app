class BeautyProduct::Scraper

  attr_accessor :name

  def initialize
    scrape_brand_page
    scrape_sale_page
    scrape_product_page
    BeautyProduct::Product.create_ingredients_array
    BeautyProduct::Product.add_ingredients
  end # initialize


  def scrape_sale_page
    cult_beauty_url = "https://www.cultbeauty.co.uk"
    sale_page = Nokogiri::HTML(open("#{cult_beauty_url}/sale.html"))

    products = sale_page.css("div.productGrid a")
    products.each do |product|
      product_name = product.css("h3.productGridTitle").text
      product_page_url = "#{cult_beauty_url}#{product.attribute("href").value}"
      new_product = BeautyProduct::Product.new(product_name)
      new_product.url = product_page_url[/[^#]+/]
    end # |product|
  end # scrape_sale_page


  def scrape_product_page
    BeautyProduct::Product.all.each do |product|
      product_page = Nokogiri::HTML(open(product.url))

      ## SET BRAND  ///##/// -- Might end up deleting this -- ///##///
      product.brand = product_page.css("h1 a div.productBrandTitle").text

      ## SET PRICE
      regular_price = product_page.css("span.productPrice.js-product-price").text
      sale_price = product_page.css("span.productSpecialPrice.js-product-special-price").text

      if sale_price.nil?
        product.price = (regular_price.to_f * 1.43).round(2).to_s
      else
        product.price = (sale_price.to_f * 1.43).round(2).to_s
      end # if price

      ## SET DESCRIPTION, HOW TO USE, & INGREDIENTS
      product_info = product_page.css(".productInfo.js-product-info ul li")
      product_info.each do |info|
        if info.css("div.itemHeader span").text == "Description"
          product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
        elsif info.css("div.itemHeader span").text == "How to use"
          product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
        elsif info.css("div.itemHeader span").text == "Full ingredients list"
          product.ingredients_string = info.css("div.itemContent").collect {|p| p.text}.join(" ")
        end # |if|
      end # |info|
    end # |product|
  end # self.scrape_product_page


  ## ///##/// -- Might end up deleting this -- ///##/// ##
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

end # class Scraper





























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

    ## ^^<#=^^ WORKING!! But, is assigning only the FIRST "p" -- FIX IT // FIX THIS
    ## try doing a .collect on all of the paragraphs and assign the array to a single variable.
    ## Then join the items in the array.
    ## OR
    ## try to do it directly  e.g. array.collect {|i| i}.join(" ") ... i.e. info.css("div.itemContent").collect { |p| p.text }.join(" ") (TRY IT)

    #product.description = product_page.css(".productInfo.js-product-info ul li")[1].text
    #product.directions = product_page.css(".productInfo.js-product-info ul li")[2].text
    #product.ingredients = product_page.css(".productInfo.js-product-info ul li")[3].text
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

===================================================
===================================================
===================================================
=================EXTRANEOUS CODE===================
===================================================
===================================================
===================================================

BeautyProduct::Scraper.scrape_brand_page
BeautyProduct::Scraper.scrape_brand_products_page
BeautyProduct::Scraper.scrape_product_page

BeautyProduct::Brand.all
BeautyProducut::Product.all


product_page = Nokogiri::HTML(open("https://www.cultbeauty.co.uk/zoeva-plaisir-box.html"))
product_info = product_page.css(".productInfo.js-product-info ul li")

product_info.each do |info|
  if info.css("div.itemHeader span").text == "Description"
    puts "DESCRIPTION!!!"
    puts info.css("div.itemContent").collect {|p| p.text}.join(" ")
  elsif info.css("div.itemHeader span").text == "How to use"
    puts "INSTRUCTIONS!!!!"
    puts info.css("div.itemContent").collect {|p| p.text}.join(" ")
  elsif info.css("div.itemHeader span").text == "Full ingredients list"
    puts "INGREDIENTS!!!"
    puts info.css("div.itemContent").collect {|p| p.text}.join(" ")
  end # |if|
end # |info|



product_info.each do |info|
  if info.css("div.itemHeader span").text == "Description"
    product.description = info.css("div.itemContent").collect {|p| p.text}.join(" ")
  elsif info.css("div.itemHeader span").text == "How to use"
    product.directions = info.css("div.itemContent").collect {|p| p.text}.join(" ")
  elsif info.css("div.itemHeader span").text == "Full ingredients list"
    product.ingredients =  info.css("div.itemContent").collect {|p| p.text}.join(" ")
  end # |if|
end # |info|



product_info.each do |info|
  if info.css("div.itemHeader span").text == "Description"
    description = info.css("div.itemContent p").text
  elsif info.css("div.itemHeader span").text == "How to use"
    directions = info.css("div.itemContent p").text
  elsif info.css("div.itemHeader span").text == "Full ingredients list"
    ingredients = info.css("div.itemContent p").text
  end # |if|
end # |info|
=end

## product_info = product_page.css(".productInfo.js-product-info ul li").text ##::CONTINUE:: YOU LEFT OFF HERE!!! -- This is a potential starting point for calling each "p"
