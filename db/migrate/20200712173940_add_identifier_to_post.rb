class AddIdentifierToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :identifier, :string, null: false, default: ''
    add_index :posts, %i[identifier site_id], unique: true

    canonical_index_is_not_uniq_anymore
  end

  def canonical_index_is_not_uniq_anymore
    remove_index :posts, name: 'index_posts_on_canonical_url'
    add_index :posts, :canonical_url
  end
end
