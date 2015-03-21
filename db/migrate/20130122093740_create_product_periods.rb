class CreateProductPeriods < ActiveRecord::Migration
  def change
    create_table :product_periods do |t|
      t.integer :product_id
      t.integer :period_id
      t.float :demand
      t.float :production
      t.float :inventory
      t.integer :setup

      t.timestamps
    end
  end
end
