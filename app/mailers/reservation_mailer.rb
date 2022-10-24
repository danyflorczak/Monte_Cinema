# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  def reservation_created
    @reservation = params[:reservation]

    mail to: @reservation.email, subject: "Reservation successfully booked"
  end

  def reservation_canceled
    @reservation = params[:reservation]

    mail to: @reservation.email, subject: "Reservation Canceled"
  end
end
