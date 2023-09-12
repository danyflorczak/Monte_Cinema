# frozen_string_literal: true

class ChangeDurationToInt < ActiveRecord::Migration[7.0]
  def up
    change_table :movies, bulk: true do |t|
      t.remove :duration
      t.integer :duration
    end
  end

  def down
    change_table :movies, bulk: true do |t|
      t.remove :duration
      t.string :duration
    end
  end
end
