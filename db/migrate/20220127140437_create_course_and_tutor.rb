class CreateCourseAndTutor < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :prerequisite
      t.timestamps
    end

    create_table :tutors do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.string :email
      t.string :highest_qualification
      t.references :course ,foreign_key:true ,null:false
      t.timestamps
    end
  end
end
