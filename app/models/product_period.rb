class ProductPeriod < ActiveRecord::Base
  attr_accessible :demand, :inventory, :period_id, :product_id, :production, :setup

  belongs_to :product
  belongs_to :period


end
