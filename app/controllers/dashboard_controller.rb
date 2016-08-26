class DashboardController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: :index

    =begin
    * Name: Sinfo-2016
    * Description: Sistema de inscrição
    * Author: Josafá Martins dos Santos
    =end

    def index
        =begin
        verificando primeiramente se o usuario está com a sessão aberta
        dentro do sistema, caso seja afirmativo então será feito uma verificação
        do atributo pay (referente se o mesmo já efetuou o pagamento). Senão será
        delegado ao metodo verify_pay para atualizar ou não esse atributo.
        =end

        if user_signed_in?
            unless current_user.pay?
                current_user.verify_pay
            end
        end
    end

    def admininstrator
    end

end
