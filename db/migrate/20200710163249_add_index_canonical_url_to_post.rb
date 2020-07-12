class AddIndexCanonicalUrlToPost < ActiveRecord::Migration[6.0]
  def change
    add_index :posts, :canonical_url, unique: true
  end
end
