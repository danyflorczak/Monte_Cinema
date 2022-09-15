# frozen_string_literal: true

class Movie < ApplicationRecord
  attribute :duration, :string
  has_many :screenings
  has_many :halls, through: :screenings
  validates :title, :duration, presence: true
end
