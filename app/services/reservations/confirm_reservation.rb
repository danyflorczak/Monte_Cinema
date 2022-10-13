# frozen_string_literal: true

module Reservations
  class ConfirmReservation
    def initialize(reservation)
      @reservation = reservation
    end

    def call
      return false unless reservation.booked?

      create_promo_code if reservation.user_id? && reservation.tickets.count >= NUM_OF_TICKETS_TO_GET_DISCOUNT
      reservation.update(status: :confirmed)
    end

    private

    attr_reader :reservation
  end
end
