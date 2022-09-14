class CreateScreenings < ActiveRecord::Migration[7.0]
  def change
    create_table :screenings do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time,null: false
      t.float :price
      t.timestamps
    end
  end
end
