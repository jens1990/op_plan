class CreateRoomSpecialties < ActiveRecord::Migration
  def change
    create_table :room_specialties do |t|
      t.integer :operating_room_id
      t.integer :specialty_id

      t.timestamps
    end
     add_index :room_specialties, :operating_room_id
     add_index :room_specialties, :specialty_id
     add_index :room_specialties, [:operating_room_id, :specialty_id], unique: true

  end
end
