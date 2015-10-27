class ChangeUsersToDonors < ActiveRecord::Migration
  def change
    rename_table :users, :donors
  end
end
