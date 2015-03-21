class Student < ActiveRecord::Base
  attr_accessible :name

  has_many :student_topics, :dependent => :destroy
end
