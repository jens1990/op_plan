class Topic < ActiveRecord::Base
  attr_accessible :shortcode, :title

  has_many :student_topics, :dependent => :destroy
end
