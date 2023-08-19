class Url < ApplicationRecord
  include Searchable
  
  validates :long_url, presence: true, length: { minimum: 10 }
  
  before_create :assign_short_url
  after_create :crawl_title
  after_update :reindex

  def self.generate_short_url(string)
    Digest::MD5.hexdigest(string)[0..6]
  end

  private

  def assign_short_url
    self.short_url = self.class.generate_short_url long_url
  end

  def crawl_title
    TitleCrawlerJob.perform_later(id)
  end

  def reindex
    __elasticsearch__.index_document
  end
end
