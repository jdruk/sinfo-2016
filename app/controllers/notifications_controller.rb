class NotificationsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :create

  def create
    transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])

    if transaction.errors.empty?
        #houve um erro
    end
    render nothing: true, status: 200
  end

end
