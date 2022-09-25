# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  has_many :halls, through: :screenings
  validates_associated :screenings, :halls
  validates :title, :description, :duration, presence: true
  validates :title, length: { maximum: 255, too_long: '%<count>s characters is the maximum allowed' }
  validates :description, length: { maximum: 30_000, too_long: '%<count>s characters is the maximum allowed' }
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
end
