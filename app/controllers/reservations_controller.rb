# frozen_string_literal: true

class ReservationsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :set_screening, only: %i[new]
  before_action :set_reservation, only: %i[confirm cancel]
  before_action :authenticate_user!, except: %i[new create_without_registration]

  def index
    @reservations = policy_scope(Reservation).includes(:tickets, :screening, :movie, :hall, :user)
  end

  def new
    authorize Reservation
    @reservation = Reservation.new
  end

  def create
    authorize Reservation
    reservation = ::Reservations::Create.new(**{ user_id: current_user.id, email: current_user.email, screening_id: params[:screening_id],
                                                 seats: params[:seats], status: :booked })

    if reservation.call
      redirect_to movies_path, notice: 'Reservation successfully created'
    else
      redirect_back fallback_location: new_screening_reservation_path(@screening),
                    alert: 'You have to chose at least one seat'
    end
  end

  def create_at_desk
    authorize Reservation
    reservation = ::Reservations::Create.new(**{ screening_id: params[:screening_id], seats: params[:seats],
                                                 email: 'Created at desk', status: :confirmed })

    if reservation.call
      redirect_to movies_path, notice: 'Reservation successfully created'
    else
      redirect_back fallback_location: new_screening_reservation_path(@screening),
                    alert: 'You have to chose at least one seat'
    end
  end

  def create_without_registration
    authorize Reservation
    reservation = ::Reservations::Create.new(**{ email: params[:email], screening_id: params[:screening_id],
                                                 seats: params[:seats], status: :booked })

    respond_to do |format|
      if @reservation.call
        @created_reservation = @reservation.created_reservation
        format.html { redirect_to movies_path, notice: 'Reservation successfully created' }
        format.json { render :show }
      else
        format.html do
          redirect_back fallback_location: new_screening_reservation_path(@screening),
                        alert: 'You have to chose at least one seat'
        end
        format.json { rrender json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    cancelation = ::Reservations::CancelReservation.new(@reservation)
    if cancelation.call
      redirect_to reservations_path, notice: 'Reservation canceled'
    else
      redirect_back fallback_location: reservations_path, alert: "Confirmed reservations can't be canceled!"
    end
  end

  def confirm
    confirmation = ::Reservations::ConfirmReservation.new(@reservation)
    if confirmation.call
      redirect_to reservations_path, notice: 'Reservation confirmed'
    else
      redirect_back fallback_location:, alert: "Canceled reservations can't be confirmed!"
    end
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_reservation
    @reservation = Reservation.includes(:tickets, :screening, :hall, :movie).find(params[:reservation_id])
  end

  def reservation_params
    params.require(:reservation).permit(:screening_id, :user_id, :email, :ticket_id, :status, :seats)
  end
end
