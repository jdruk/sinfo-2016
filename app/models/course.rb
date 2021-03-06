class Course < ActiveRecord::Base
    enum type_day: [:first_day, :second_day]

    validates :name, presence: true
    validates :type_day, presence: true

    has_many :course_users
    has_many :user, through: :course_users

    def self.available dia
        cursos = Course.where( type_day: dia )
        confirmados = cursos.to_a.select {|c| c.course_users.where(pay: 1).count < 20 }
    end
end
