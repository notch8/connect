class AddDomainToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :sub_domain, :string
  end
end
