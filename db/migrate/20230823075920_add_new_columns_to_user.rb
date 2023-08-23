class AddNewColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :uuid, :string
    add_column :users, :avatar_url, :string
    add_column :users, :provider, :string
  end
end
