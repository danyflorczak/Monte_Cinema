# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :status, default: 0, null: false
      t.belongs_to :screening, :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
