class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?
	before_filter do
		resource = controller_name.singularize.to_sym
		method = "#{resource}_params"
		params[resource] &&= send(method) if respond_to?(method, true)
	end

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_path, :alert => exception.message
	end

  def after_sign_in_path_for(resource)
  	# Set default redirect path based on user's role
  	if resource.admin?
  		redirect_path = users_path
  	elsif resource.vip?
  		redirect_path = stocks_path
  	else
  		redirect_path = stocks_path
  	end
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || redirect_path
    end
  end


	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) do |u|
				u.permit(:name, :email, :password, :password_confirmation, :current_password, :role_ids)
			end
			devise_parameter_sanitizer.for(:account_update) do |u|
				u.permit(:name, :email, :password, :password_confirmation, :current_password, :role_ids)
			end
		end
end
