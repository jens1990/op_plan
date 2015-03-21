class CreateDemandsites < ActiveRecord::Migration
  def change
    create_table :demandsites do |t|
      t.integer :site_id
      t.float :demand_quantity

      t.timestamps
    end
  end
end
