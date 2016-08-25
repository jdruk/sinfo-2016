class User < ActiveRecord::Base
  has_many :course_users
  has_many :courses, through: :course_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
