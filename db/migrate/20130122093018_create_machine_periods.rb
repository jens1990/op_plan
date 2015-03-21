class CreateMachinePeriods < ActiveRecord::Migration
  def change
    create_table :machine_periods do |t|
      t.integer :machine_id
      t.integer :period_id
      t.float :capacity
      t.float :overtime

      t.timestamps
    end
  end
end
