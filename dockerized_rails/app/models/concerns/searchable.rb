module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name 'urls'

    mapping do
      indexes :short_url, type: :text
      indexes :long_url, type: :text
      indexes :title, type: :text
    end

    def self.search(query)
      self.__elasticsearch__.search(query)
    end
  end
end
