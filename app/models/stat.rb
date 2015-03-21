class Stat < ActiveRecord::Base
  attr_accessible :calculation_id, :day, :idle_time, :not_sat_in, :not_sat_out, :specialty_id
belongs_to :specialty
belongs_to :calculation_room
end
