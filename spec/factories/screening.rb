# frozen_string_literal: true

FactoryBot.define do
  factory :screening do
    association :movie
    association :hall
    start_time { DateTime.current.beginning_of_minute }
    price { rand(1..10) }
  end
end
