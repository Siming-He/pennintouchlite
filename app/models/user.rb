class User < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :courses, through: :registrations
  validates :first_name, :last_name, :pennkey, :password_hash, presence: true
  validates :pennkey, uniqueness: true

  def full_name
    first_name + " " + last_name
  end

  def self.students
    User.where(is_instructor: false)
  end

  def self.instructors
    User.where(is_instructor: true)
  end

end
