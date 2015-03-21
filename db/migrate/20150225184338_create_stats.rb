class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :calculation_id
      t.integer :specialty_id
      t.string :day
      t.integer :not_sat_out
      t.integer :not_sat_in
      t.integer :idle_time

      t.timestamps
    end
  end
end
