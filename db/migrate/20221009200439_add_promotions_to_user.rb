# frozen_string_literal: true

class AddPromotionsToUser < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :promotions, :user, foreign_key: true
  end
end
