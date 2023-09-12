# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    Reservations::ConfirmReservation.new(@reservation).call
  end
end
