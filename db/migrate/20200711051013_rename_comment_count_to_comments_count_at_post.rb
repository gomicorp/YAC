class RenameCommentCountToCommentsCountAtPost < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :comment_count, :comments_count
  end
end
