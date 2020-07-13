class AddDisplayedCommentsCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :displayed_comments_count, :integer, null: false, default: 0
  end
end
