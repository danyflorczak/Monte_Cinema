# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  validates_associated :movie, :hall
  validates :start_time, :end_time, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def available_seats
    taken_seats = []
    reservations.each do |reservation|
      reservation.tickets.each do |ticket|
        taken_seats.push(ticket.seat)
      end
    end
    hall.seats - taken_seats
  end
end
