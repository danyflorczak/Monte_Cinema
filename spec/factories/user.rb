# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    password { 'password' }
    role { :client }
    before(:create, &:skip_confirmation!)
  end
end
