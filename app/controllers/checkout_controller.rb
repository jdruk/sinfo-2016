class CheckoutController < ApplicationController
  def create
    # O modo como você irá armazenar os produtos que estão sendo comprados
    # depende de você. Neste caso, temos um modelo Order que referência os
    # produtos que estão sendo comprados.
    payment = PagSeguro::PaymentRequest.new

    # Você também pode fazer o request de pagamento usando credenciais
    # diferentes, como no exemplo abaixo

    payment.reference = current_user.id
    #payment.notification_url = notifications_url
    #payment.redirect_url = 'processing_url'


    payment.items << {
        id: 100,
        description: 'inscrição evento',
        amount: 10.00
    }

    unless current_user.nenhuma?
        payment.items << {
            id: 101,
            description: current_user.shirkt,
            amount: 40.00
        }
    end

    current_user.courses.each do |c|
        payment.items << {
            id: c.id,
            description: c.name,
            amount: 15.00
        }
    end

    response = payment.register
    # Caso o processo de checkout tenha dado errado, lança uma exceção.
    # Assim, um serviço de rastreamento de exceções ou até mesmo a gem
    # exception_notification poderá notificar sobre o ocorrido.
    #
    # Se estiver tudo certo, redireciona o comprador para o PagSeguro.
    if response.errors.any?
      raise response.errors.join("\n")
    else
      current_user.url_token = response.code
      current_user.save
      redirect_to response.url
    end
  end
end
