class CreateTranslinks < ActiveRecord::Migration
  def change
    create_table :translinks do |t|
      t.integer :supplysite_id
      t.integer :demandsite_id
      t.float :unit_cost
      t.float :transport_quantity

      t.timestamps
    end
  end
end
