class TicketsController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    confirmation = ::Reservations::ConfirmReservation.new(@reservation)
  end
end
