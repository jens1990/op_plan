class CreateOperatingRooms < ActiveRecord::Migration
  def change
    create_table :operating_rooms do |t|
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end
