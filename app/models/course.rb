class Course < ApplicationRecord
	has_many :tutors, dependent: :destroy
	serialize :prerequisite , Array
	validates :name, presence:true
	validates :name , uniqueness:{message:"Course has already been created"}
	accepts_nested_attributes_for :tutors
end