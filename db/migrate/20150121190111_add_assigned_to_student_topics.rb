class AddAssignedToStudentTopics < ActiveRecord::Migration
  def change
    add_column :student_topics, :assigned, :boolean
  end
end
