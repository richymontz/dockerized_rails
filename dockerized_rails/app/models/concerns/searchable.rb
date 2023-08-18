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
      params = {
        query: {
          multi_match: {
            query: query, 
            fields: [:short_url, :long_url, :title ],
            type: 'phrase_prefix'
          },
        },
      }

      self.__elasticsearch__.search(params)
    end
  end
end
