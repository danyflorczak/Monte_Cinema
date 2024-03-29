# frozen_string_literal: true

class ScreeningsController < ApplicationController
  before_action :set_screening, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show]

  def index
    authorize Screening
    @pagy, @screenings = pagy(Screening.includes(:movie, :hall))
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
    @screening = ::Screenings::Create.new(screening_params).call
    if @screening.errors.any?
      render :new, status: :unprocessable_entity
    else
      redirect_to screening_url(@screening), notice: I18n.t("screening.create")
    end
  end

  def update
    authorize Screening
    @screening = ::Screenings::Update.new(params[:id], screening_params).call

    if @screening.errors.any?
      render :edit, status: :unprocessable_entity
    else
      redirect_to screening_url(@screening), notice: I18n.t("screening.update")
    end
  end

  def destroy
    authorize Screening
    ::Screenings::Delete.new(params[:id]).call

    redirect_to screenings_url, notice: I18n.t("screening.destroy")
  end

  private

  def set_screening
    @screening = Screening.find(params[:id])
  end

  def screening_params
    params.require(:screening).permit(:movie_id, :hall_id, :start_time, :end_time, :price)
  end
end
