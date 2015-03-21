class MachinePeriod < ActiveRecord::Base
  attr_accessible :capacity, :machine_id, :overtime, :period_id

  belongs_to :machine
  belongs_to :period

end



