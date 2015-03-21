class Patient < ActiveRecord::Base
  attr_accessible :age, :city, :name, :op_time, :specialty_id, :startday_of_stay, :type_of_patient

  belongs_to :specialty

  validates :specialty_id, :op_time, :startday_of_stay, presence: true

end
