class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :canonical_url
      t.string :thumbnail_url
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
