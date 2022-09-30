# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { 'My title' }
    description { 'My description' }
    duration { 120 }
  end
end
