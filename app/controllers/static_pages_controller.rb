# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @movies = Movie.all
  end

  def about; end
end
