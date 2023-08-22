# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  has_many :halls, through: :screenings
  has_one_attached :poster_image

  validates_associated :screenings, :halls
  validates :title, :description, :duration, presence: true
  validates :title, uniqueness: true
  validates :description, length: { maximum: 1000, too_long: "%<count>s characters is the maximum allowed" }
  validates :duration, numericality: { greater_than: 0 }
end
