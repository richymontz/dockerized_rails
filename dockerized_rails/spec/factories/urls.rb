FactoryBot.define do
  factory :url do
    long_url { "http://www.google.com" }

    trait :with_short_url do
      short_url { "shorty" }
    end

    trait :with_title do
      title { "Some Title" }
    end
  end
end