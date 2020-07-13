class AddHideAtToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :hide_at, :datetime
  end
end
