# frozen_string_literal: true

module Reservations
  class Create
    def initialize(email:, screening_id:, status:, seats:, user_id: nil)
      @user_id = user_id
      @email = email
      @screening_id = screening_id
      @status = status
      @seats = seats
      @errors = []
    end

    attr_reader :errors, :reservation

    def call
      return false unless seats_selected? && seats_available?

      ActiveRecord::Base.transaction do
        @reservation = Reservation.create!(screening_id: @screening_id, user_id: @user_id, email: @email,
          status: @status,)
        create_tickets
      end

      ReservationMailer.with(reservation: @reservation).reservation_created.deliver_later unless @status == :confirmed
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
      errors << "Booking reservation failed!, errors that prohibited from saving: #{e.message}"
      false
    end

    private

    def seats_available?
      screening = Screening.find_by(id: @screening_id)

      if screening&.all_taken_seats&.intersection(@seats)&.empty? && screening&.available_seats&.intersection(@seats)&.any?
        true
      else
        errors << "Seats already taken or incorrect"
        false
      end
    end

    def create_tickets
      @seats.each do |seat|
        @reservation.tickets.create(seat:)
      end
    end

    def seats_selected?
      if @seats.nil? || @seats.empty?
        errors << "Please select your seat(s)"
        return false
      end
      true
    end
  end
end
