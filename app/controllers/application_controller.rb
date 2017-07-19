class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def generate_braintree_client_token
    result = Braintree::Customer.create(
      :first_name => "Jen",
      :last_name => "Smith",
      :company => "Braintree",
      :email => "jen@example.com",
      :phone => "312.555.1234",
      :fax => "614.555.5678",
      :website => "www.example.com"
    )
    Braintree::ClientToken.generate(customer_id: result.customer.id)
  end
end
