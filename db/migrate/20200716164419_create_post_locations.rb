class CreatePostLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :post_locations do |t|
      t.string :address, null: false, default: ''
      t.references :post, null: false, foreign_key: true
      t.integer :visit_count, null: false, default: 0

      t.timestamps
    end

    add_index :post_locations, :address
    add_index :post_locations, %i[post_id address], unique: true
  end
end
