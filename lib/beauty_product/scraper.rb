class BeautyProduct::Scraper

  attr_accessor :name

  def self.scrape_brand_page

    sephora_url = "https://www.sephora.com"
    cult_beauty_url = "https://www.cultbeauty.co.uk"
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
        new_product = BeautyProduct::Product.new(product_name)
        product_page_url = "#{cult_beauty_url}#{product.attribute("href").value}"
        new_product.url = product_page_url[/[^#]+/]
      end # |product|
    end # |brand|
  end # self.scrape_brand_products_page

  def self.scrape_product_page
    BeautyProduct::Product.all.each do |product|
      product_page = Nokogiri::HTML(open(product.url))
      product_info = product_page.css(".productInfo.js-product-info ul li")

      #product_info = product_page.css(".productInfo.js-product-info ul li")
      product.price = product_page.css("span.productPrice.js-product-price").text.to_f ## ATTENTION:  .to_f  converting to float here!! ... Might cause problems later.

      product_info.each do |info|
        if info.css("div.itemHeader span").text == "Description"
          product.description = info.css("div.itemContent p").text
        elsif info.css("div.itemHeader span").text == "How to use"
          product.directions = info.css("div.itemContent p").text
        elsif info.css("div.itemHeader span").text == "Full ingredients list"
          product.ingredients = info.css("div.itemContent p").text
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

end # class Scraper

=begin
product_info.each do |info|
  if info.css("div.itemHeader span").text == "Description"
    puts "DESCRIPTION!!!"
    puts info.css("div.itemContent p").text
  elsif info.css("div.itemHeader span").text == "How to use"
    puts "INSTRUCTIONS!!!!"
    puts info.css("div.itemContent p").text
  elsif info.css("div.itemHeader span").text == "Full ingredients list"
    puts "INGREDIENTS!!!"
    puts info.css("div.itemContent p").text
  end # |if|
end # |info|
=end

## product_info = product_page.css(".productInfo.js-product-info ul li").text ##::CONTINUE:: YOU LEFT OFF HERE!!! -- This is a potential starting point for calling each "p"
