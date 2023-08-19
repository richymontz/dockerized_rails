FactoryBot.define do
  factory :url do
    long_url { "http://localhost:3000/example" }

    trait :with_short_url do
      short_url { "shorty" }
    end

    trait :with_title do
      title { "Some Title" }
    end
  end
end