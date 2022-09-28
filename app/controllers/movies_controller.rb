# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    authorize Movie
    @movies = Movie.all
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
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movie_url(@movie), notice: 'Movie was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize Movie
    if @movie.update(movie_params)
      redirect_to movie_url(@movie), notice: 'Movie was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Movie
    @movie.destroy
    redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  private

  def set_movie
    @movie = authorize Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :duration)
  end
end
