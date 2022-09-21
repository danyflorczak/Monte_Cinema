# frozen_string_literal: true

class RemoveCurrentUserModel < ActiveRecord::Migration[7.0]
  def change
    drop_table :users
  end
end
