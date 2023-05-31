# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    association :reservation
    seat { 1 }
  end
end
