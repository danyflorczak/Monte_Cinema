# frozen_string_literal: true

class AddHallsToScreening < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :screenings, :hall, foreign_key: true, null: false
  end
end
