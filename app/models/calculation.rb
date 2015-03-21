class Calculation < ActiveRecord::Base
  attr_accessible :user_id, :workhours_perDay, :gamspath

  belongs_to :user
  has_many :assignments, :dependent => :destroy
  has_many :demand0s, :dependent => :destroy
  has_many :demand1s, :dependent => :destroy
  has_many :demand2s, :dependent => :destroy
  has_many :stats, :dependent => :destroy
  has_many :calculation_rooms

  validates :user_id, presence: true
  validates :workhours_perDay, :numericality => { :greater_than => 0}


end
