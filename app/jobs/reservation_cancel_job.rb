# frozen_string_literal: true

class ReservationCancelJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    reservations = Reservation.booked

    reservations.map do |reservation|
      screening = Screening.find(reservation.screening_id)
      ::Reservations::CancelReservation.new(reservation).call if screening.start_time < DateTime.now - 30.minutes
    end
  end
end
