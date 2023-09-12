# frozen_string_literal: true

FactoryBot.define do
  factory :promotion do
    user
    value { rand(5..10) }
    description { Faker::Lorem.sentence }
    code { rand(15..24) }
  end
end
