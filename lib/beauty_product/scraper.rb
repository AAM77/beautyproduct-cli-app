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

  








end # class Scraper
