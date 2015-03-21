class Assignment < ActiveRecord::Base
  attr_accessible :Fri, :Mon, :Thu, :Tue, :Wed, :calculation_id, :operating_room_id, :specialty_id

  belongs_to :calculation
  belongs_to :operating_room
  belongs_to :specialty

end
