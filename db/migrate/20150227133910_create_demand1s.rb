class CreateDemand1s < ActiveRecord::Migration
  def change
    create_table :demand1s do |t|
      t.integer :calculation_id
      t.integer :specialty_id
      t.integer :Mon
      t.integer :Tue
      t.integer :Wed
      t.integer :Thu
      t.integer :Fri

      t.timestamps
    end
  end
end
