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
      return false unless valid_reservation?

      ActiveRecord::Base.transaction do
        create_reservation
        create_tickets
      end

      send_reservation_email unless @status == :confirmed
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
      errors << "Booking reservation failed! Errors that prohibited from saving: #{e.message}"
      false
    end

    private

    def valid_reservation?
      seats_selected? && seats_available?
    end

    def create_reservation
      @reservation = Reservation.create!(
        screening_id: @screening_id,
        user_id: @user_id,
        email: @email,
        status: @status
      )
    end

    def create_tickets
      @seats.each do |seat|
        @reservation.tickets.create(seat:)
      end
    end

    def seats_selected?
      if @seats.blank?
        errors << "Please select your seat(s)"
        false
      else
        true
      end
    end

    def seats_available?
      screening = Screening.find_by(id: @screening_id)

      if seats_not_taken?(screening) && seats_exist?(screening)
        true
      else
        errors << "Seats already taken or incorrect"
        false
      end
    end

    def seats_not_taken?(screening)
      return false if screening.blank?

      taken_seats = screening.all_taken_seats || Set.new
      taken_seats.intersection(@seats).empty?
    end

    def seats_exist?(screening)
      return false if screening.blank?

      available_seats = screening.available_seats || Set.new
      available_seats.intersection(@seats).any?
    end

    def send_reservation_email
      ReservationMailer.with(reservation: @reservation).reservation_created.deliver_later
    end
  end
end
