# frozen_string_literal: true

class DropUserRole < ActiveRecord::Migration[7.0]
  def change
    execute 'DROP TABLE user_roles CASCADE'
  end
end
