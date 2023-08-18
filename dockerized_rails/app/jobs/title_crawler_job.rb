class TitleCrawlerJob < ApplicationJob
  queue_as :default

  def perform(url_id)
    url = Url.find_by(id: url_id)

    scraper = Scraper.new(url.long_url)
    title_text = scraper.crawl_by_tagname('title').text
    
    url.update!(title: title_text)
  end
end
