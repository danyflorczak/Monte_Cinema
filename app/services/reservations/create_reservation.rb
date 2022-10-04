# frozen_string_literal: true

module Reservations
  class CreateReservation
    def initialize(user_id,email, screening_id, seats)
      @user_id = user_id
      @email = email
      @screening_id = screening_id
      @seats = seats
      @reservation = Reservation.new(screening_id:, user_id:, email:)
    end

    def call
      return false unless seats_selected?

      ActiveRecord::Base.transaction do
        @reservation.save!
        create_tickets
      end
    end

    private

    attr_reader :seats

    def create_tickets
      seats.each do |seat|
        @reservation.tickets.create(seat:)
      end
    end

    def seats_selected?
      !seats.nil?
    end
  end
end
