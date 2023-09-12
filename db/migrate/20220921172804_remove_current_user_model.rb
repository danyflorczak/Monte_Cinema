# frozen_string_literal: true

class RemoveCurrentUserModel < ActiveRecord::Migration[7.0]
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
