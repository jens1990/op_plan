# == Schema Information
#
# Table name: translinks
#
#  id                 :integer          not null, primary key
#  supplysite_id      :integer
#  demandsite_id      :integer
#  unit_cost          :float
#  transport_quantity :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Translink < ActiveRecord::Base
  attr_accessible :demandsite_id, :supplysite_id, :transport_quantity, :unit_cost
  validates :transport_quantity, :numericality => { :greater_than_or_equal_to => 0}
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0}

  belongs_to :supplysite
  belongs_to :demandsite
end
