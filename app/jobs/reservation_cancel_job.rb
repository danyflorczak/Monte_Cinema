# frozen_string_literal: true

class ReservationCancelJob < ApplicationJob
  queue_as :default

  def perform
    reservations = Reservation.booked
    half_hour_before_screening = DateTime.now - 30.minutes
    reservations.map do |reservation|
      screening = Screening.find(reservation.screening_id)
      ::Reservations::CancelReservation.new(reservation).call if screening.start_time <= half_hour_before_screening
    end
  end
end
