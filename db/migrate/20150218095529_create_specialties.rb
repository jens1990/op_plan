class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :shortcode
      t.string :name

      t.timestamps
    end
  end
end
