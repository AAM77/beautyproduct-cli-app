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

      product.description = product_page.css(".productInfo.js-product-info ul li")[1].text
      product.directions = product_page.css(".productInfo.js-product-info ul li")[2].text
      product.ingredients = product_page.css(".productInfo.js-product-info ul li")[3].text
    end # |product|
  end # self.scrape_product_page

end # class Scraper
