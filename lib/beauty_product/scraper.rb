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
    BeautyProduct::Brand.all.each do |brand|
      brand_page = Nokogiri::HTML(open(brand.url))

      products = brand_page.css("div.productGrid a")
      products.each do |product|
        new_product = BeautyProduct::Product.new(product.text)
        new_product.url = "#{cult_beauty_url}#{url.attribute("href").value}"
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






  https://www.cultbeauty.co.uk/zoeva-plaisir-box.html#af=brand%3azoeva&cip=71.168.146.27&isort=globalpop&lgkey=https%3a%2f%2fwww.cultbeauty.co.uk%2fzoeva-plaisir-box.html&lgsku=ZOE119&lot
  =json&method=and&p=R&rk=1&rsc=fHC43098c0V8H4UZ&ts=json-full&ua=Ruby&uid=619092410&url=https%3a%2f%2fwww.cultbeauty.co.uk%2fzoeva-plaisir-box.html&w=*#clktrack&typ
  e=product&list=brand&rk=0



end # class Scraper
