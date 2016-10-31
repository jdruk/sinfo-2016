class CertificateController < ApplicationController
  layout 'certificate_layout'
  
  def create_certificate
     if user_signed_in? 
      unless current_user.pay?
        redirect_to root_path, notice: 'É preciso efetuar o pagamento para poder realizar a emissão de certificados!'
      end
    else
      redirect_to root_path
    end
  end
end
