class BeautyProduct::Scraper

  attr_accessor :name

  def self.scrape_brand_page

    sephora_url = "https://www.sephora.com"
    doc = Nokogiri::HTML(open("#{sephora_url}/brand/list.jsp"))

    brands = doc.css("a.u-hoverRed.u-db.u-p1")
    brands.each do |brand|
      new_brand = BeautyProduct::Brand.new(brand.text)
      new_brand.url = "#{sephora_url}#{brand.attribute("href").value}?products=all&pageSize=-1"
    end # do |brand|
  end # scrape_brands

  def self.scrape_brand_products_page
    BeautyProduct::Brand.all.each do |brand|
      brand_page = Nokogiri::HTML(open(brand.url))

      products = brand_page.css("div.SkuGrid").first
      products.each do |product|
        new_product = BeautyProduct::Product.new(product.text)
      end # |product|
    end # |brand|
  end # self.scrape_brand_products









end # class Scraper
