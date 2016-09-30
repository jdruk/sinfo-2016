class DashboardController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: :index
    before_action :authenticate_user!, except: [:index]

    # =begin
    # * Name: Sinfo-2016
    # * Description: Sistema de inscrição
    # * Author: Josafá Martins dos Santos
    # =end

    def index
        # =begin
        # verificando primeiramente se o usuario está com a sessão aberta
        # dentro do sistema, caso seja afirmativo então será feito uma verificação
        # do atributo pay (referente se o mesmo já efetuou o pagamento). Senão será
        # delegado ao metodo verify_pay para atualizar ou não esse atributo.
        # =end

        if user_signed_in? && (!current_user.admin?)
            if current_user.pay?
                flash[:notice] =  "Seu pagamento foi confirmado! Obg..."
            else
                # Função critica do sistema! Testar antes de colocar em produção
                current_user.verify_pay
                if current_user.error_pay?
                    flash[:error] =  "Por favor contate os administradores do SINFO!"
                end
            end
        end
    end

    def admininstrator
        authorize :dashboard, :admininstrator?
        @courses = Course.all
        @contacts = Contact.all
        
        if params[:atualizar]
           users = User.where pay: 0
           users.each do |user|
               user.verify_pay
           end
        end
        
        @users_pay = User.where pay: 1
        @users_unpay = User.where pay: 0
        @courseusers = CourseUser.where pay: 1
    end
    
end
