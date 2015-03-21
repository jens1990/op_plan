class ProductProduct < ActiveRecord::Base
  attr_accessible :coefficient, :from_product_id, :to_product_id
  validates :coefficient, :numericality => { :greater_than => 0}, :presence => true


  belongs_to :from_product, class_name: "Product"
  belongs_to :to_product, class_name: "Product"

end

