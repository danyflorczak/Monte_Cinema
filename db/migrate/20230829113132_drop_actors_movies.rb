# frozen_string_literal: true

class DropActorsMovies < ActiveRecord::Migration[7.0]
  def up
    drop_table :actors_movies
  end

  def down
    create_table :actors_movies do |t|
      t.references :actor, foreign_key: true
      t.references :movie, foreign_key: true
      t.timestamps
    end
  end
end
