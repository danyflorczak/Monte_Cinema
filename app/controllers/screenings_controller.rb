# frozen_string_literal: true

class ScreeningsController < ApplicationController
  before_action :set_screening, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    authorize Screening
    @screenings = Screening.includes(:movie, :hall)
  end

  def show
    authorize Screening
  end

  def new
    @screening = Screening.new
    authorize Screening
  end

  def edit
    authorize Screening
  end

  def create
    authorize Screening
    @screening = Screening.new(screening_params)
    if @screening.save
      redirect_to screening_url(@screening), notice: 'Screening was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize Screening
    if @screening.update(screening_params)
      redirect_to screening_url(@screening), notice: 'Screening was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Screening
    @screening.destroy
    redirect_to screenings_url, notice: 'Screening was successfully destroyed.'
  end

  private

  def set_screening
    @screening = Screening.find(params[:id])
  end

  def screening_params
    params.require(:screening).permit(:movie_id, :hall_id, :start_time, :end_time, :price)
  end
end
