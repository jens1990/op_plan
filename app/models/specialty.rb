class Specialty < ActiveRecord::Base
  attr_accessible :name, :shortcode
  validates :shortcode, length: {maximum: 3}
  validates :shortcode, uniqueness: true

  has_many :Room_specialties, :dependent => :destroy
  has_many :patients, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  has_many :demand0s, :dependent => :destroy
  has_many :demand1s, :dependent => :destroy
  has_many :demand2s, :dependent => :destroy
  has_many :stats, :dependent => :destroy
end
