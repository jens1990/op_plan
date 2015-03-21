class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.integer :workhours_perDay
      t.integer :user_id

      t.timestamps
    end
    add_index :calculations, [:user_id, :created_at]
  end
end
