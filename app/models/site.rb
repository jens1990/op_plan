# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  codename   :string(3)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base
  attr_accessible :codename, :name
  validates :codename, presence: true, length: {maximum: 3, minimum: 3}
  validates :name, presence: true, length: {maximum: 50}

  has_many :supplysites, :dependent => :destroy
  has_many :demandsites, :dependent => :destroy
  has_many :translinks, :through => :demandsites
  has_many :translinks, :through => :supplysites
  accepts_nested_attributes_for :supplysites
  accepts_nested_attributes_for :demandsites
end
