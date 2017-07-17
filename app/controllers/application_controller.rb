class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def generate_braintree_client_token
    Braintree::ClientToken.generate
  end
end
