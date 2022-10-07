# frozen_string_literal: true

module Reservations
  class CreateAtDesk
    def initialize(screening_id, seats)
      @screening_id = screening_id
      @seats = seats
      @reservation = Reservation.new(screening_id:, status: :confirmed, email: 'Created at desk')
    end

    def call
      return false unless seats_selected? && seats_available?

      ActiveRecord::Base.transaction do
        reservation.save!
        create_tickets
      end
    end

    private

    attr_reader :seats, :reservation

    def seats_available?
      (Screening.find(@screening_id).all_taken_seats & seats ).empty?
    end

    def create_tickets
      seats.each do |seat|
        reservation.tickets.create(seat:)
      end
    end

    def seats_selected?
      !seats.nil?
    end
  end
end
