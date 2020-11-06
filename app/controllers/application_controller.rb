class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  alias_method :current_user, :current_api_user

  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: [exception.message] }, status: 403
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me
                     avatar first_name last_name phone_number programming_skill
                     date_of_birth profession user_type]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def not_found
    render json: { errors: ['Page not found'] }, status: 404
  end
end
