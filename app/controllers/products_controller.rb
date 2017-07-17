class ProductsController < ApplicationController
  def show
    gon.client_token = generate_braintree_client_token
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def buy
    result = Braintree::Transaction.sale(
      amount: params[:amount],
      payment_method_nonce: params[:payment_method_nonce],
      options: {
        submit_for_settlement: true
      }
    )
    if result.success?
      redirect_back(fallback_location: root_path, notice: 'Everything was fine!')
    else
      redirect_back(fallback_location: root_path, notice: 'Something went wrong! :/')
    end
  end
end
