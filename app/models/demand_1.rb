class Demand_1 < ActiveRecord::Base
  attr_accessible :Fri, :Mon, :Thu, :Tue, :Wed, :calculation_id, :specialty_id

  belongs_to :calculation
  belongs_to :specialty

end
