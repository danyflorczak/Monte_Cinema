# frozen_string_literal: true

class Remove < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user_role_id
  end
end
