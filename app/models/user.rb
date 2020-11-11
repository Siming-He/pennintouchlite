class User < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :courses, through: :registrations
end
