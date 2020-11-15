class Course < ApplicationRecord
  belongs_to :department
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  validates :department, :code, :title, :description, presence: true
  validates :department_id, uniqueness: {scope: :code}

  def full_code
    Department.where(id: department_id)[0][:code] + '-' + code.to_s
  end 

  def instructor
    course = Course.find(id)
    user_cur = course.users.find_by(is_instructor: true)
    user_cur[:last_name] + ", " + user_cur[:first_name]
  end

  def instructor=(user)
    if user.is_instructor
      Registration.create({course: Course.find(id), user: user})
    end
  end

  def students
    course = Course.find(id)
    course.users.where(is_instructor: false).to_a
  end

end
