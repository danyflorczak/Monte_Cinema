# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_screening, only: %i[new create create_at_desk create_without_registration]
  before_action :set_reservation, only: %i[confirm cancel]
  before_action :authenticate_user!, except: %i[new create_without_registration]

  def index
    @pagy, @reservations = pagy(policy_scope(Reservation).includes(:tickets, screening: [:movie, :hall]))
  end

  def show
    authorize Reservation
    @reservation = Reservation.find(params[:id])
    setup_payment_processor
  end

  def new
    authorize Reservation
    @reservation = Reservation.new
  end

  def create
    authorize Reservation
    @reservation = create_reservation(current_user.id, current_user.email, :booked)
    if @reservation.call
      redirect_to reservation_path(@reservation.reservation), notice: I18n.t("reservation.create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create_at_desk
    authorize Reservation
    @reservation = create_reservation(nil, "Created at desk", :confirmed)

    if @reservation.call
      redirect_to reservation_path(@reservation.reservation), notice: I18n.t("reservation.create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create_without_registration
    authorize Reservation
    @reservation = create_reservation(nil, params[:email], :booked)

    if @reservation.call
      redirect_to reservation_path(@reservation.reservation), notice: I18n.t("reservation.create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def cancel
    cancelation = ::Reservations::CancelReservation.new(@reservation)
    if cancelation.call
      redirect_to reservations_path, notice: I18n.t("reservation.canceled")
    else
      redirect_back fallback_location: reservations_path, alert: I18n.t("reservation.alerts.confirmed")
    end
  end

  def confirm
    confirmation = ::Reservations::ConfirmReservation.new(@reservation)
    if confirmation.call
      redirect_to reservations_path, notice: I18n.t("reservation.confirmed")
    else
      redirect_back fallback_location: reservations_path, alert: I18n.t("reservation.alerts.canceled")
    end
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def set_reservation
    @reservation = Reservation.includes(:tickets, :screening, :hall, :movie).find(params[:reservation_id])
  end

  def create_reservation(user_id, email, status)
    ::Reservations::Create.new(
      user_id:,
      email:,
      screening_id: params[:screening_id],
      seats: params[:seats],
      status:
    )
  end

  def reservation_params
    params.require(:reservation).permit(:screening_id, :user_id, :email, :ticket_id, :status, :seats)
  end

  def setup_payment_processor
    current_user.set_payment_processor(:stripe)
    current_user.payment_processor.customer
    @checkout_session = payment_processor_checkout(current_user)
  end

  def calculate_unit_amount
    @reservation.screening.price.to_i * 100 * @reservation.tickets.count
  end

  def movie_details
    { name: @reservation.screening.movie.title, description: @reservation.screening.movie.description }
  end

  def payment_processor_checkout(current_user)
    current_user.payment_processor.checkout(mode: "payment",
                                            line_items: [
                                              { price_data: { currency: "pln",
                                                              product_data: movie_details,
                                                              unit_amount: calculate_unit_amount },
                                                quantity: 1 }
                                            ],
                                            success_url: reservation_tickets_url(@reservation),
                                            cancel_url: reservation_url(@reservation))
  end
end
