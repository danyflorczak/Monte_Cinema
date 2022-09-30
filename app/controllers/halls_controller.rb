# frozen_string_literal: true

class HallsController < ApplicationController
  before_action :set_hall, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @halls = Hall.all
    authorize Hall
  end

  def show
    authorize Hall
  end

  def new
    @hall = Hall.new
    authorize Hall
  end

  def edit
    authorize Hall
  end

  def create
    authorize Hall
    @hall = ::Halls::Create.new(hall_params).call

    if @hall.valid?
      redirect_to hall_url(@hall), notice: 'Hall was successfully created.'
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
      redirect_to hall_url(@hall), notice: 'Hall was successfully updated.'
    end
  end

  def destroy
    authorize Hall
    ::Halls::Delete.new(params[:id]).call

    redirect_to halls_url, notice: 'Hall was successfully destroyed.'
  end

  private

  def set_hall
    @hall = authorize Hall.find(params[:id])
  end

  def hall_params
    params.require(:hall).permit(:name, :capacity)
  end
end
