# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  def reservation_created
    @reservation = params[:reservation]

    mail to: @reservation.email, subject: 'Reservation successfully booked'
  end
end
