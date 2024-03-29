# frozen_string_literal: true

class HallsController < ApplicationController
  before_action :set_hall, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    authorize Hall
    @halls = Hall.all
  end

  def show
    authorize Hall
  end

  def new
    authorize Hall
    @hall = Hall.new
  end

  def edit
    authorize Hall
  end

  def create
    authorize Hall
    @hall = ::Halls::Create.new(hall_params).call

    if @hall.valid?
      redirect_to hall_url(@hall), notice: I18n.t("hall.create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize Hall
    @hall = ::Halls::Update.new(params[:id], hall_params).call

    if @hall.errors.any?
      render :edit, status: :unprocessable_entity
    else
      redirect_to hall_url(@hall), notice: I18n.t("hall.update")
    end
  end

  def destroy
    authorize Hall
    ::Halls::Delete.new(params[:id]).call

    redirect_to halls_url, notice: I18n.t("hall.destroy")
  end

  private

  def set_hall
    @hall = Hall.find(params[:id])
  end

  def hall_params
    params.require(:hall).permit(:name, :capacity)
  end
end
