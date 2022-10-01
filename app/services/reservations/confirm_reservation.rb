# frozen_string_literal: true

module Reservations
  class ConfirmReservation
    def initialize(reservation)
      @reservation = reservation
    end

    def call
      return false unless reservation.booked?

      reservation.update(status: :confirmed)
    end

    private

    attr_reader :reservation
  end
end
