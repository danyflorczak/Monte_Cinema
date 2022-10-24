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

    def create_promo_code
      Promotion.create(
        value: PROMO_VALUE,
        description: "Use code at cash desk in our Cinema and get price cut for our assortment in food bar!",
        code: rand(1000..3000),
        user_id: reservation.user_id,
      )
    end
  end
end
