# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i(show edit update destroy)
  before_action :authenticate_user!, except: %i(index show)

  def index
    authorize Movie
    @movies = Movie.includes(:screenings)
    @screenings = Screening.all
  end

  def show
    authorize Movie
    @screenings = Screening.all
  end

  def new
    authorize Movie
    @movie = Movie.new
  end

  def edit
    authorize Movie
  end

  def create
    authorize Movie
    @movie = ::Movies::Create.new(movie_params).call
    if @movie.valid?
      redirect_to movie_url(@movie), notice: "Movie was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize Movie
    @movie = ::Movies::Update.new(params[:id], movie_params).call
    if @movie.errors.any?
      render :edit, status: :unprocessable_entity
    else
      redirect_to movie_url(@movie), notice: "Movie was successfully updated."
    end
  end

  def destroy
    authorize Movie
    ::Movies::Delete.new(params[:id]).call
    redirect_to movies_url, notice: "Movie was successfully destroyed."
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :duration, :poster_image, :director, :release_date, :cast,
      :genre,)
  end
end
