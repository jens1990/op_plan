# == Schema Information
#
# Table name: supplysites
#
#  id              :integer          not null, primary key
#  site_id         :integer
#  supply_quantity :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Supplysite < ActiveRecord::Base
  attr_accessible :supply_quantity, :site_id
  validates :supply_quantity, :numericality => { :greater_than => 0}


  belongs_to :site
  has_many :translinks, :dependent => :destroy
  accepts_nested_attributes_for :translinks


  def supplysite_codename
    self.site.codename
  end
end
