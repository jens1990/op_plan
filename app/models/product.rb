class Product < ActiveRecord::Base
  attr_accessible :holding_cost, :initial_inventory, :lead_time_periods, :name, :processing_time, :setup_cost, :setup_time

  has_many :product_periods, :dependent => :destroy
  has_many :product_products, foreign_key: "from_product_id", :dependent => :destroy
  has_many :reverse_product_products, foreign_key: "to_product_id", class_name: "ProductProduct", :dependent => :destroy
  has_many :product_machines, :dependent => :destroy

#  accepts_nested_attributes_for :product_products

end
