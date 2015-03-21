class CreateProductProducts < ActiveRecord::Migration
  def change
    create_table :product_products do |t|
      t.integer :from_product_id
      t.integer :to_product_id
      t.integer :coefficient

      t.timestamps
    end
  end
end
