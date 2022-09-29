# frozen_string_literal: true

module Reservations
  class CreateAtDesk
    def initialize(screening_id, seats)
      @screening_id = screening_id
      @seats = seats
      @reservation = Reservation.new(screening_id:, status: :confirmed)
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
