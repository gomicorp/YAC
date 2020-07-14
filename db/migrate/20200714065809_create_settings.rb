class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.references :site, null: false, foreign_key: true
      t.boolean :comment_repeatable, null: false, default: false

      t.timestamps
    end
  end
end
