# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create]
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(screening_id: params[:screening_id], status: :created)

    if !params.key?(:seats)
      @reservation.errors.add(:base, 'You have to choose at least one seat')
      render :new, status: :unprocessable_entity
    else
      @reservation.save
      create_tickets
      redirect_to movies_path, notice: 'Reservation successfully created'
    end
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def create_tickets
    params[:seats].each do |seat|
      Ticket.create(reservation_id: @reservation.id, seat:)
    end
  end
end
