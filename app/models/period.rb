class Period < ActiveRecord::Base
  attr_accessible :name

  has_many :product_periods, :dependent => :destroy
  has_many :machine_periods, :dependent => :destroy

end
