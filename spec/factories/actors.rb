# frozen_string_literal: true

FactoryBot.define do
  factory :actor do
    name { Faker::Name.name }
  end
end
