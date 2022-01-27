class Tutor < ApplicationRecord
	belongs_to :course
	serialize :highest_qualification, Hash
	validates :mobile_number,:email,:first_name,:email_confirmation, presence:true
	validates :email,:mobile_number , uniqueness:{message:"%{value} is already taken"}
	validates :email, confirmation:true
	validates :mobile_number, length:{is:10,message:"%{value} should be of 10 digit" }
end