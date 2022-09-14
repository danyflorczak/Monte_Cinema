class AddMovieToScreening < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :screenings, :movie, foreign_key: true, null: false
  end
end
