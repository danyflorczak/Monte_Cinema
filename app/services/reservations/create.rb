# frozen_string_literal: true

module Reservations
  class Create
    def initialize(**kwargs)
      @user_id = kwargs[:user_id]
      @email = kwargs[:email]
      @screening_id = kwargs[:screening_id]
      @status = kwargs[:status]
      @seats = kwargs[:seats]
      @errors = []
      @reservation = Reservation.new(screening_id: @screening_id, user_id: @user_id, email: @email, status: @status)
    end

    attr_reader :errors

    def call
      return false unless seats_selected? && seats_available?

      ActiveRecord::Base.transaction do
        reservation.save!
        create_tickets
      end
      ReservationMailer.with(reservation:).reservation_created.deliver_later unless @status == :confirmed
      reservation
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
      errors << "Reservation unsuccessful, errors that prohibited from saving: #{e.message}"
      false
    end

    private

    attr_reader :seats, :reservation

    def seats_available?
      if (Screening.find(@screening_id).all_taken_seats & seats).empty?
        true
      else
        errors << 'Seats already taken'
        false
      end
    end

    def create_tickets
      seats.each do |seat|
        reservation.tickets.create(seat:)
      end
    end

    def seats_selected?
      if seats.nil?
        errors << 'Please select your seat(s)'
        return false
      elsif seats.empty?
        errors << 'Please select your seat(s)'
        return false
      end
      true
    end
  end
end
