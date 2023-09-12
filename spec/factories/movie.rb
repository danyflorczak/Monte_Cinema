# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Movie.quote }
    duration { Faker::Number.number(digits: 2).to_i }
    genre { Faker::Book.genre }
    director { Faker::Name.name }
    release_date { Faker::Date.between(from: 20.years.ago, to: Time.zone.today) }
  end
end
