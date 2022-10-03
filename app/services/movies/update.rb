# frozen_string_literal: true

module Movies
  class Update
    def initialize(movie_id, params)
      @movie_id = movie_id
      @params = params
    end

    def call
      movie = Movie.find(movie_id)
      movie.update(params)
      movie
    end

    private

    attr_reader :movie_id, :params
  end
end
