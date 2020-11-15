class RegistrationsController < ApplicationController
  before_action :set_course
  before_action :set_user
  before_action :authenticate_user
  before_action :ensure_admin_student, only: [:add_course, :drop_course]

  def add_course
    if !@user.is_instructor && !@course.students.include?(@user)
      @course.students << @user
      @course.student = @user
    end
    redirect_to @user
  end

  def drop_course
    unless @user.is_instructor
      @course.students.delete_at(@course.students.index(@user))
      @course.student_drop = @user
    end
    redirect_to @user
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def ensure_admin_student
    redirect_to users_path unless @user == (User.find(session[:user_id])) && !@user.is_instructor
  end
end
