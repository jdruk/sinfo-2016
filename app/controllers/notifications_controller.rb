class NotificationsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :create

  def create
    transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])

    if transaction.errors.empty?
      # Processa a notificação. A melhor maneira de se fazer isso é realizar
      # o processamento em background. Uma boa alternativa para isso é a
      # biblioteca Sidekiq.
    end
    
    puts '\n\n\n\n\n\n\n\n\n'
    puts "Chegouuuuuuuuuuuuuruuuuuuuuuuuuuuuuuuuuu"
    puts params[:notificationCode]
    puts '\n\n\n\n\n\n\n\n\n'
    render nothing: true, status: 200
  end
end
