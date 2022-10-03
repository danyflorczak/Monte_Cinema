# frozen_string_literal: true

module Movies
  class Delete
    def initialize(movie_id)
      @movie_id = movie_id
    end

    def call
      movie = Movie.find(movie_id)
      movie.destroy
    end

    private

    attr_reader :movie_id
  end
end
