class CreateSupplysites < ActiveRecord::Migration
  def change
    create_table :supplysites do |t|
      t.integer :site_id
      t.float :supply_quantity

      t.timestamps
    end
  end
end
