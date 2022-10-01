# frozen_string_literal: true

FactoryBot.define do
  factory :hall do
    name { 'My name' }
    capacity { Faker::Number.number(digits: 2).to_i }
  end
end
