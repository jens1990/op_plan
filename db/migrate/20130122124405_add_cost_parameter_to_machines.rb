class AddCostParameterToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :overtime_cost, :float
  end
end
