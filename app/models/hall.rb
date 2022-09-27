# frozen_string_literal: true

class Hall < ApplicationRecord
  has_many :screenings
  has_many :movies, through: :screenings
  validates_associated :screenings, :movies
  validates :name, :capacity, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  validates :name, uniqueness: true

  def seats
    (1..capacity).map(&:to_s)
  end
end
