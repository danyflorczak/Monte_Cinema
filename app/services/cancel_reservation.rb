# frozen_string_literal: true

class CancelReservation
  def initialize(reservation)
    @reservation = reservation
  end

  def call
    return false unless booked?

    reservation.update(status: :canceled)
  end

  private

  attr_reader :reservation

  def booked?
    reservation.status == 'booked'
  end
end
