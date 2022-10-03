class ReservationCancelJob
  include Sidekiq::Job

  def perform(*args)
    reservations = Reservation.includes(:tickets, :screening, :movie, :hall, :user).where(status: :booked)
    reservations.map do |reservation|
      
    end
  end
end
