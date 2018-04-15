class BeautyProduct::Scraper

  sephora = Nokogiri::HTML(open("https://www.sephora.com/brand/list.jsp"))



  def self.products
  end # products

  def self.scrape_brands
    brands = []

    brand = brand.new
    brand.name = "Acqua Di Parma"
    brand.url = "https://www.sephora.com/acqua-di-parma?products=all"
  end # scrape_brands

  def self.scrape_brand_page(brand_page)

  end # scrape_brands

  def self.scrape_brand_products(brand_url)

  end # scrape brand_products

end # class Scraper
