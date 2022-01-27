class CoursesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		courses = Course.all
		courses_and_its_tutor  = courses.map {|course| {name:course.name, 
			tutors: course.tutors.
				select(:first_name,:last_name,:email,:mobile_number,:id,:highest_qualification)}}
		render json:courses_and_its_tutor
	end

	def new

	end

	def create
		if(Course.find_by(name:course_params[:name]))
			@course = Course.find_by(name:course_params[:name])
			add_tutor_to_exisiting_course
		else 
			@course = course_params
			create_course_tutor
		end
		render json: @data ,status:@status
	end

	def add_tutor_to_exisiting_course
		if(course_params[:tutors_attributes].nil?)
			@errors = "please add tutors"
			post_failed
			return
		end
		@errors =[]
		isvalid = true
		course_params[:tutors_attributes].each do |tutor|
			temp = @course.tutors.new(tutor)
			if(!temp.valid?) 
				isvalid =false 
			end
			@errors << temp.errors
		end
		isvalid ? save_tutor_to_exixiting_course : post_failed 
	end

	def save_tutor_to_exixiting_course
		@course.tutors.create(course_params[:tutors_attributes])
		post_success
	end

	def create_course_tutor
		@course= Course.new(@course)
		if(@course.save)
			post_success
		else
			@errors = @course.errors
			post_failed
		end
	end

	def post_success
		@data = {success:true}
		@status = 201
	end

	def post_failed
		@status = 400
		@data = {success:false,errors:@errors}
	end
	private 
	def course_params
		params.require(:course).
		permit(:name,prerequisite:[],
			tutors_attributes:[:first_name,:last_name,:mobile_number,:email,:email_confirmation,
							highest_qualification:[:degree,:college]])
	end
end




