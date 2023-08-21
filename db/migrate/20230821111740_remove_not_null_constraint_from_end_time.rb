# frozen_string_literal: true

class RemoveNotNullConstraintFromEndTime < ActiveRecord::Migration[7.0]
  def change
    change_column_null :screenings, :end_time, true
  end
end
