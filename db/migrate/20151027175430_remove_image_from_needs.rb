class RemoveImageFromNeeds < ActiveRecord::Migration
  def change
    remove_column :needs, :image_file_name
    remove_column :needs, :image_content_type
    remove_column :needs, :image_file_size
    remove_column :needs, :image_updated_at
  end
end
