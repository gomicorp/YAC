class CreateOmniAuthIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :omni_auth_identities do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
