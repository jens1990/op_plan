class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :setup_time
      t.float :processing_time
      t.float :setup_cost
      t.float :holding_cost
      t.float :initial_inventory
      t.integer :lead_time_periods

      t.timestamps
    end
  end
end
