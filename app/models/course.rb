class Course < ActiveRecord::Base
    enum type_day: [:first_day, :second_day]

    validates :name, presence: true
    validates :type, presence: true    

    has_many :course_users
    has_many :user, through: :course_users

    def self.available dia
        cursos = Course.where( type: dia )
        confirmados = cursos.to_a.select {|c| c.registereds.where(pay: 1).count < 30 }
    end
end
