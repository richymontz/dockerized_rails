require 'open-uri'

class Scraper

  attr_accessor :document

  def initialize(url)
    @document = Nokogiri::HTML(URI.open(url))
  end
  
  def crawl_by_tagname(tagname)
    @document.at_css(tagname)
  end
end