# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/reservation_created
  def reservation_created
    ReservationMailer.reservation_created
  end
end
