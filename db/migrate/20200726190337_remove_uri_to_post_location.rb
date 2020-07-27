class RemoveUriToPostLocation < ActiveRecord::Migration[6.0]
  def change
    remove_column :post_locations, :uri
  end
end
