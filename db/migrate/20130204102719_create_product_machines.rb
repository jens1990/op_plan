class CreateProductMachines < ActiveRecord::Migration
  def change
    create_table :product_machines do |t|
      t.integer :product_id
      t.integer :machine_id

      t.timestamps
    end
  end
end
