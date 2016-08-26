class User < ActiveRecord::Base
  has_many :course_users
  has_many :courses, through: :course_users
  
  enum pay: [ :unpay,:pay ]
  enum shirkt: [ :nenhuma,:grande, :media,:pequena ]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def value_total
      #valor da inscrição
      value = Sinfo::VALUE_INSCRIPTION
      #Valor da camisa
      unless self.nenhuma?
          value += Sinfo::VALUE_SHIRKT
      end
      #valor por curso
      total_courses = Sinfo::VALUE_COURSE * self.courses.count
      return value + total_courses
  end

end
