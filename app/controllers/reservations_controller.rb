# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create create_at_desk]
  before_action :set_reservation, only: %i[edit update destroy]
  before_action :authenticate_user!

  def index
    @reservations = policy_scope(Reservation).includes(:tickets, :screening, :movie, :hall, :user)
  end

  def new
    authorize Reservation
    @reservation = Reservation.new
  end

  def edit
    authorize Reservation
  end

  def create
    authorize Reservation
    reservation = CreateReservation.new(current_user.id, params[:screening_id], params[:seats])

    if reservation.call
      redirect_to movies_path, notice: 'Reservation successfully created'
    else
      redirect_back fallback_location: new_screening_reservation_path(@screening),
                    alert: 'You have to chose at least one seat'
    end
  end

  def create_at_desk
    authorize Reservation
    reservation = CreateAtDesk.new(params[:screening_id], params[:seats])

    if reservation.call
      redirect_to movies_path, notice: 'Reservation successfully created'
    else
      redirect_back fallback_location: new_screening_reservation_path(@screening),
                    alert: 'You have to chose at least one seat'
    end
  end

  def update
    authorize Reservation

    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: 'Reservation status was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Reservation

    @reservation.destroy
    redirect_to reservations_url, notice: 'Reservation was successfully deleted.'
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_reservation
    @reservation = authorize Reservation.includes(:tickets, :screening, :hall, :movie).find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:screening_id, :user_id, :ticket_id, :status, :seats)
  end
end
