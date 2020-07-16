class AddLocationsCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :locations_count, :integer, null: false, default: 0
  end
end
