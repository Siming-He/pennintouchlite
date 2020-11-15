require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

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

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
