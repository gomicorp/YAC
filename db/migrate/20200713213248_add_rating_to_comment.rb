class AddRatingToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :rating, :integer, null: false, default: 0
  end
end
