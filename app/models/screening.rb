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
    reservations.each do |reservation|
      all_taken_seats << reservation.tickets.pluck(:seat)
    end
    hall.seats - all_taken_seats.flatten
  end
end
