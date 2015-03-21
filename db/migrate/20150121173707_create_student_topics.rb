class CreateStudentTopics < ActiveRecord::Migration
  def change
    create_table :student_topics do |t|
      t.integer :student_id
      t.integer :topic_id
      t.integer :preference

      t.timestamps
    end
  end
end
