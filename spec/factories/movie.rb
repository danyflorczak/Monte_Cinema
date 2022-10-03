# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Movie.quote }
    duration { Faker::Number.number(digits: 2).to_i }
  end
end
