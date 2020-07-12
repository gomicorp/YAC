class AddApiKeyToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :api_key, :string
    add_index :organizations, :api_key, unique: true
  end
end
