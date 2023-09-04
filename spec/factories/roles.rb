# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { "MyString" }
    actor
    movie
  end
end
