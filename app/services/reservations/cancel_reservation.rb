# frozen_string_literal: true

module Reservations
  class CancelReservation
    def initialize(reservation)
      @reservation = reservation
    end

    def call
      return false unless booked?

      reservation.canceled!
      reservation.tickets.destroy_all
    end

    private

    attr_reader :reservation

    def booked?
      reservation.status == 'booked'
    end
  end
end
