# frozen_string_literal: true

class AddNewColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :full_name
      t.string :uuid
      t.string :avatar_url
      t.string :provider
    end
  end
end
