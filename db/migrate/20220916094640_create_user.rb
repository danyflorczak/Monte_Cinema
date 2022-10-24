# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string "email", null: false
      t.string "name"
      t.integer "role", default: 0, null: false
      t.timestamps
    end
  end
end
