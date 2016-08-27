class User < ActiveRecord::Base
    has_many :course_users
    has_many :courses, through: :course_users

    enum pay: [ :unpay,:pay,:error_pay ]
    enum role: [ :normal,:admin]
    enum shirkt: [ :nenhuma,:grande, :media,:pequena ]

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    accepts_nested_attributes_for :course_users

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

    def verify_pay
        transaction = PagSeguro::Transaction.find_by_reference(self.id)
        while transaction.next_page?
            transaction.next_page!
            if transaction.transactions.count == 0
                #flash[:notice] = "Não encontramos nenhum pagamento referente a sua inscrição"
            end
            transaction.transactions.each do |transaction|
                if transaction.status == 'waiting_pay'
                    if current_user.value_total == transaction.gross_amount.to_f
                        current_user.pay = :pay
                    elsif condition
                        #flash[:error] =  "Por favor contate os administradores do SINFO!"
                        current_user.pay = :error_pay
                    end
                end
            end
        end
    end
end
