class ProductMachine < ActiveRecord::Base
  attr_accessible :machine_id, :product_id

  belongs_to :product
  belongs_to :machine

end
