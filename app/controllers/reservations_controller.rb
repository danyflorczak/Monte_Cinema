# frozen_string_literal: true

class ReservationsController < ApplicationController
  def new
    @screening = Screening.find(params[:screening_id])
  end
end
