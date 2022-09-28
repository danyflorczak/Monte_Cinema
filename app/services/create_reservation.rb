# frozen_string_literal: true

class CreateReservation
  def initialize(user_id, screening_id, seats)
    @user_id = user_id
    @screening_id = screening_id
    @seats = seats
    @reservation = Reservation.new(screening_id: screening_id,user_id: user_id, status: :created)
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
