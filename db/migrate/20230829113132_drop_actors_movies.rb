# frozen_string_literal: true

class DropActorsMovies < ActiveRecord::Migration[7.0]
  def change
    drop_table :actors_movies
  end
end
