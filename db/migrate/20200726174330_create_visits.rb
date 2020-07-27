class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.text :uri
      t.references :post_location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
