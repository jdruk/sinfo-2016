class User < ActiveRecord::Base
    has_many :course_users
    has_many :courses, through: :course_users
    
    
    enum pay: [ :unpay,:pay,:error_pay ]
    enum role: [ :normal,:admin]
    enum shirkt: [ :nenhuma,:grande_masculina, :media_masculina,:pequena_masculina,
            :grande_feminino, :media_feminino,:pequena_feminino]

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
                puts "== Page #{transaction.page}"
                abort "=> Errors: #{transaction.errors.join("\n")}" unless transaction.valid?
                puts "Report created on #{transaction.created_at}"
                puts

                transaction.transactions.each do |transaction|
                    puts "=> Transaction"
                    puts "   created_at: #{transaction.created_at}"
                    puts "   code: #{transaction.code}"
                    puts "   payment method: #{transaction.payment_method.type}"
                    puts "   gross amount: #{transaction.gross_amount.to_f}"
                    puts "   updated at: #{transaction.updated_at}"
                    puts "   status: #{transaction.status.status}"
                    if transaction.status.paid?
                        if transaction.gross_amount.to_f == self.value_total
                            self.pay = :pay
                            course_users.each do |course|
                                course.pay = 1
                            2end
                        else
                           self.pay = :error_pay
                        end
                        self.save
                    end
                end
            end
    end
end
