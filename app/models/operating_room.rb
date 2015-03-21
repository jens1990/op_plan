class OperatingRoom < ActiveRecord::Base
  attr_accessible :amount, :name

  has_many :room_specialties, :dependent => :destroy
  has_many :calculation_rooms, :dependent => :destroy
  has_many :assignments

  validates :amount, presence: true

end
