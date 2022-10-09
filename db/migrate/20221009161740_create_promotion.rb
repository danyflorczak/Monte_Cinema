# frozen_string_literal: true

class CreatePromotion < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.integer :value, null: false
      t.string :description, null: false
      t.integer :code

      t.timestamps
    end
  end
end
