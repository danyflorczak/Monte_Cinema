# frozen_string_literal: true

class AddUserToReservation < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :reservations, :user, foreign_key: true, null: false
  end
end
