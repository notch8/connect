class ChangeUserAssociationsToDonor < ActiveRecord::Migration
  def change
    rename_column :sent_messages, :user_id, :donor_id
    rename_column :donations, :user_id, :donor_id
  end
end
