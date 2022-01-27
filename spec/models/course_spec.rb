require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'can not be created if' do
    it 'is  without name' do
      expect {Course.create!}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'has name that already exist in database' do
      course1 = Course.create!(name:"Physics")
      expect {Course.create!(name:"Physics")}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'can be created if' do
    it 'has name but not prerequisite' do 
      Course.create(name:"Physics")
      expect(Course.count).to eq 1
    end 
    it 'has name and prerequisite' do
      Course.create(name:'angular',prerequisite:%w[html,javascript])
      expect(Course.count).to eq 1
    end
  end
end
