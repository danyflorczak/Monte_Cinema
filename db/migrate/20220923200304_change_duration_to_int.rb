# frozen_string_literal: true

class ChangeDurationToInt < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :duration
    add_column :movies, :duration, :integer
  end
end
