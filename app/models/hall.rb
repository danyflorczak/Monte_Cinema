# frozen_string_literal: true

class Hall < ApplicationRecord
  has_many :screenings
  has_many :movies, through: :screenings
  validates :name, :capacity, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :name, uniqueness: true

  def seats_arr
    (1..capacity).map(&:to_s)
  end
end
