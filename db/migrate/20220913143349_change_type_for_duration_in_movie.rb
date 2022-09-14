class ChangeTypeForDurationInMovie < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :duration
    add_column :movies, :duration, :interval
  end
end
