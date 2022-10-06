class ReservationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.reservation_created.subject
  #
  def reservation_created
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
