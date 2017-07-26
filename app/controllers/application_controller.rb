class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation first_name last_name phone])
  end

  def generate_braintree_client_token
    if user_signed_in?
      result = Braintree::Customer.create(
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        email: current_user.email,
        phone: current_user.phone
      )
      customer_id = result.customer.id
      current_user.update(customer_id_braintree: customer_id)
      Braintree::ClientToken.generate(customer_id: customer_id)
    end
  end
end
