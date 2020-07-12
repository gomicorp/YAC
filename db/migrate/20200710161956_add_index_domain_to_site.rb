class AddIndexDomainToSite < ActiveRecord::Migration[6.0]
  def change
    add_index :sites, :domain, unique: true
  end
end
