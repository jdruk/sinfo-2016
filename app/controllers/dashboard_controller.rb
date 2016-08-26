class DashboardController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :index

  def index
    if user_signed_in?
        unless current_user.pay?
            transaction = PagSeguro::Transaction.find_by_reference(current_user.id)
            while transaction.next_page?
              transaction.next_page!
              puts "== Page #{transaction.page}"
              abort "=> Errors: #{transaction.errors.join("\n")}" unless transaction.valid?
              puts "Report created on #{transaction.created_at}"
              puts
              if transaction.transactions.count == 0
                  flash[:notice] = "Não encontramos nenhum pagamento referente a sua inscrição"
              end
              transaction.transactions.each do |transaction|
                if transaction.status_code == 3
                    if current_user.value_total == transaction.gross_amount.to_f
                        current_user.pay = :pay
                    elsif condition
                         flash[:error] =  "Por favor contate os administradores do SINFO!"
                         current_user.pay = :error_pay
                    end
                end
            end
        end
      end
    end
  end

  def admininstrator
  end
end
