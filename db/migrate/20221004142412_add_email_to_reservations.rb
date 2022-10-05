# frozen_string_literal: true

class AddEmailToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :email, :string, null: false
  end
end
