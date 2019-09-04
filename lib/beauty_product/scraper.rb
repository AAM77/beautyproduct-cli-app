class BeautyProduct::Scraper

  def initialize
    scrape_sale_page
    scrape_product_page
    BeautyProduct::Product.create_ingredients_array ## Not sure if I need this...
    #BeautyProduct::Product.add_ingredients
  end # initialize

  ##################################################################
  ##  SCRAPES THE SALES PAGE FOR: Product Name, Product Page url  ##
  ##################################################################
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

  #############################################################################
  ## SCRAPES INFORMATION NECESSARY TO GENERATE A DESCRIPTION FOR THE PRODUCT ##
  #############################################################################
  def create_description(product, info)
    product.description = info.css("div.itemContent").collect {|p| p.text.strip}.join(" ")
  end

  #########################################################################################
  ## SCRAPES EACH PRODUCT PAGE FOR: Brand, Price, Description, Directions, & Ingredients ##
  #########################################################################################

  def scrape_product_page
    BeautyProduct::Product.all.each do |product|
      product_page = Nokogiri::HTML(open(product.url))

      product.brand            = product_page.css("h1 a div.productBrandTitle").text
      product.sale_price       = (product_page.css("span.productSpecialPrice.js-product-special-price").text.to_f * 1.43).round(2)

      ## SET PRODUCT DESCRIPTION, DIRECTIONS, & INGREDIENTS ##
      product_info = product_page.css(".productInfo.js-product-info ul li")

      product_info.each do |info|
        #DESCRIPTION
        if info.css("div.itemHeader span").text == "Description"
          create_description(product, info)

        #DIRECTIONS
        elsif info.css("div.itemHeader span").text == "How to use"
          product.directions  = info.css("div.itemContent").collect {|p| p.text.strip}.join(" ")

        #INGREDIENTS
        elsif info.css("div.itemHeader span").text == "Full ingredients list"
          product.ingredients_string = info.css("div.itemContent").collect {|p| p.text.strip}.join(" ")
        end # if css().text == 'Description', 'How to use', 'Full Ingredients list'

        product.add_ingredients
      end # do |info|
    end # do |product|
  end # scrape_product_page
end # class Scraper
###################
## END OF CLASS  ##
###################
