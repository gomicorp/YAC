class LocationVisitColumnMakeSeparate < ActiveRecord::Migration[6.0]
  def up
    PostLocation.destroy_all
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
