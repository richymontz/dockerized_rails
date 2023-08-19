require 'open-uri'

class Scraper

  attr_accessor :document

  def initialize(url)
    @document = Nokogiri::HTML(request_url(url))
  end
  
  def crawl_by_tagname(tagname)
    @document.at_css(tagname)
  end

  def request_url(url)
    URI.open(url)
  end
end