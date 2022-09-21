# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create]
  before_action :set_reservation, only: %i[edit update destroy]
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def edit; end

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

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: 'Reservation status was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_url, notice: 'Reservation was successfully deleted.'
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def create_tickets
    params[:seats].each do |seat|
      Ticket.create(reservation_id: @reservation.id, seat:)
    end
  end

  def reservation_params
    params.require(:reservation).permit(:screening_id, :ticket_id, :status)
  end
end
