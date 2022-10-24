# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    association :screening
    email { "testemail@gmail.com" }
    status { :booked }
  end
end
