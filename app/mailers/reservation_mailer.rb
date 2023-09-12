# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  def reservation_created
    @reservation = params[:reservation]

    mail to: @reservation.email, subject: I18n.t("reservation.mailer.booked")
  end

  def reservation_canceled
    @reservation = params[:reservation]

    mail to: @reservation.email, subject: I18n.t("reservation.mailer.canceled")
  end
end
