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
        
        #valor por curso
        total_courses = 0
        if self.courses.count == 2
            total_courses = 15
        elsif 
            self.courses.count == 1
            total_courses = 10
        end
        
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
                        puts transaction.gross_amount.to_f 
                        puts self.value_total
                        if transaction.gross_amount.to_f == self.value_total
                            self.pay = :pay
                            course_users.each do |course|
                            course.pay = 1
                        end
                    else
                          self.pay = :error_pay
                    end
                        self.save
                    end
                end
            end
    end
end
