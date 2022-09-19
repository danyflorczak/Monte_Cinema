# frozen_string_literal: true

class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @screening = Screening.find(params[:screening_id])
  end
end
