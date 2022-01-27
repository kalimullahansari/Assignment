require 'rails_helper'

RSpec.describe Tutor, type: :model do
  context 'can not be created if' do
    it 'is without course_id' do
        expect {Tutor.create!(first_name:"kalimullah", last_name:"ansari", mobile_number:"9633700513", email:"123@gmail.com",email_confirmation:"123@gmail.com")}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'can be created if' do
    it "have first_name, mobile_number,email and have course_id" do
      course = Course.create(name:"Physics")
      course.tutors.create(first_name:"kalimullah", last_name:"ansari", mobile_number:"9633700513", email:"123@gmail.com",email_confirmation:"123@gmail.com")
      expect(Tutor.count).to eq 1
    end
  end
  context 'can not be created if' do
    it 'have not mobile_number' do
      course = Course.create(name:"Physics")
      course.tutors.create(first_name:"kalimullah", last_name:"ansari", email:"123@gmail.com",email_confirmation:"123@gmail.com")
      expect(Tutor.count).to eq 0
    end
    it 'have not mobile_number of 10 digit' do
      course = Course.create(name:"Physics")
      course.tutors.create(first_name:"kalimullah", last_name:"ansari", mobile_number:"963370051", email:"123@gmail.com",email_confirmation:"123@gmail.com")
      expect(Tutor.count).to eq 0
    end
    it 'have mobile_number that is already registered' do 
      course = Course.create(name:"Physics")
      course.tutors.create(first_name:"kalimullah", last_name:"ansari", mobile_number:"9633700513", email:"123@gmail.com",email_confirmation:"123@gmail.com")
      course.tutors.create(first_name:"abhishek", last_name:"anand", mobile_number:"9633700513", email:"1234@gmail.com",email_confirmation:"1234@gmail.com")
      expect(Tutor.count).to eq 1
    end
      it 'have not email' do 
      course = Course.create(name:"Physics")
      course.tutors.create(first_name:"kalimullah", last_name:"ansari", mobile_number:"9633700513",email_confirmation:"123@gmail.com")
      expect(Tutor.count).to eq 0
    end
      it 'have not email and email_confirmation same' do 
        course = Course.create(name:"Physics")
        course.tutors.create(first_name:"kalimullah", last_name:"ansari", mobile_number:"9633700513",email:"12@gmail.com",email_confirmation:"123@gmail.com")
        expect(Tutor.count).to eq 0
      end
      it 'have email that is already registered' do
        course = Course.create(name:"Physics")
        course.tutors.create(first_name:"kalimullah", last_name:"ansari", mobile_number:"9633700513", email:"123@gmail.com",email_confirmation:"123@gmail.com")
        course.tutors.create(first_name:"abhishek", last_name:"anand", mobile_number:"1234567890", email:"123@gmail.com",email_confirmation:"123@gmail.com")
        expect(Tutor.count).to eq 1
      end
      it 'have not first name' do
        course = Course.create(name:"Physics")
        course.tutors.create(last_name:"ansari", mobile_number:"9633700513", email:"123@gmail.com",email_confirmation:"123@gmail.com")
        expect(Tutor.count).to eq 0
      end
  end
end
