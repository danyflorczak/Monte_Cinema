# frozen_string_literal: true

class AddBillingLocationToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :city
      t.string :country
    end
  end
end
