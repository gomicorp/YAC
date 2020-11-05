class AddCommentDisplayFieldsToSetting < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :comment_display_created_at, :boolean, null: false, default: true
  end
end
