# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @movies = Movie.includes(poster_image_attachment: :blob)
  end
end
