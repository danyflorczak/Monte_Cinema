# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates_associated :movie, :hall
  validates :start_time, :end_time, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def available_seats
    all_taken_seats = []
    all_taken_seats = reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
    hall.seats - all_taken_seats.flatten
  end
end
