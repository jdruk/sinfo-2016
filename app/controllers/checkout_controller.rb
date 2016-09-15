class CheckoutController < ApplicationController
  def create
    # O modo como você irá armazenar os produtos que estão sendo comprados
    # depende de você. Neste caso, temos um modelo Order que referência os
    # produtos que estão sendo comprados.
    payment = PagSeguro::PaymentRequest.new

    # Você também pode fazer o request de pagamento usando credenciais
    # diferentes, como no exemplo abaixo

    payment.reference = current_user.id
    payment.notification_url = 'http://sinfoufpi.com.br/notifications'
    payment.redirect_url = 'http://sinfoufpi.com.br'


    payment.items << {
        id: 100,
        description: 'inscrição evento',
        amount: Sinfo::VALUE_INSCRIPTION
    }

    @aumount = 10
    if current_user.courses.count == 2
      @aumount = 7.50
    end
    current_user.courses.each do |c|
        payment.items << {
            id: c.id,
            description: c.name,
            amount: @aumount
        }
    end

    response = payment.register

    if response.errors.any?
      raise response.errors.join("\n")
    else
      current_user.url_token = response.code
      current_user.save
      redirect_to response.url
    end
  end
end
