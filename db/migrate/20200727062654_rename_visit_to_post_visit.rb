class RenameVisitToPostVisit < ActiveRecord::Migration[6.0]
  def up
    rename_table :visits, :post_visits
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
