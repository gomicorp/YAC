class AddRatingToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :rating_avg, :float, null: false, default: 0
  end
end
