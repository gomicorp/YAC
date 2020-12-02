class ChangeColumnTypeToTextForPostLocationAddress < ActiveRecord::Migration[6.0]
  def change
    remove_index(:post_locations, column: :address)
    remove_index(:post_locations, column: [:post_id, :address])
    change_column :post_locations, :address, :text, default: nil
    add_index(:post_locations, :address, length: 255)
    add_index(:post_locations, [:post_id, :address], unique: true, length: { address: 255 })
  end
end
