class CreateOrganizationAdminPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_admin_permissions do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
