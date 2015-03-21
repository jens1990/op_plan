class StudentTopic < ActiveRecord::Base
  attr_accessible :assigned, :preference, :student_id, :topic_id
  belongs_to :student
  belongs_to :topic
end