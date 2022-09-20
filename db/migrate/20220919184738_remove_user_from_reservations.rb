# frozen_string_literal: true

class RemoveUserFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :user_id
  end
end
