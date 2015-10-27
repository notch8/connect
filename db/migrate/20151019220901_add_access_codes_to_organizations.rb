class AddAccessCodesToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :access_code, :string
  end
end
