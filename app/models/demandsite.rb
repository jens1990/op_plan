# == Schema Information
#
# Table name: demandsites
#
#  id              :integer          not null, primary key
#  site_id         :integer
#  demand_quantity :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Demandsite < ActiveRecord::Base
  attr_accessible :demand_quantity, :site_id
  validates :demand_quantity, :numericality => { :greater_than => 0}

  belongs_to :site
  has_many :translinks, :dependent => :destroy
  accepts_nested_attributes_for :translinks


  def demandsite_codename
    self.site.codename
  end

end
