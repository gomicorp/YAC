class AddUriToPostLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :post_locations, :uri, :text
  end
end
