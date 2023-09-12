# frozen_string_literal: true

class AddUniqueConstraintToNameInHalls < ActiveRecord::Migration[7.0]
  def change
    add_index :halls, :name, unique: true
  end
end
