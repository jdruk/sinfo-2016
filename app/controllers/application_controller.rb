class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up)  { |u| u.permit(:name,  :cpf,
            :telephone,:email,:password,
            :password_confirmation, :shirkt,
            course_users_attributes: [:id, :user_id, :course_id])}
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    private
	def user_not_authorized
		flash[:alert] = "Você não tem permissão para acessar este item"
		redirect_to(request.referrer || root_path)
    end
end
