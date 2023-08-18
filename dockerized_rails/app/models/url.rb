class Url < ApplicationRecord
  validates :long_url, presence: true, length: { minimum: 10 }
  before_create :assign_short_url

  def self.generate_short_url(string)
    Digest::MD5.hexdigest(string)[0..6]
  end

  private

  def assign_short_url
    self.short_url = self.class.generate_short_url long_url
  end
end
