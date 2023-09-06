# frozen_string_literal: true

class AddPropertiesToMovies < ActiveRecord::Migration[7.0]
  def change
    change_table :movies do |t|
      t.string :genre
      t.string :director
      t.datetime :release_date
    end
  end
end
