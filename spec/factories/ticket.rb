# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    reservation
    seat { 1 }
  end
end
