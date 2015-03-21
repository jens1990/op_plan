class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :city
      t.integer :type_of_patient
      t.string :startday_of_stay
      t.integer :op_time
      t.integer :specialty_id

      t.timestamps
    end
  end
end
