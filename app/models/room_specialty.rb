class RoomSpecialty < ActiveRecord::Base
  attr_accessible :operating_room_id, :specialty_id

  belongs_to :specialty
  belongs_to :operating_room

end
