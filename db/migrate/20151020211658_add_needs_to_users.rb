class AddNeedsToUsers < ActiveRecord::Migration
  def change
    add_column :needs, :user_id, :integer
  end
end
