class CartsController < ApplicationController
  before_action :logged_in_user, only: %i[show destroy]

  def show
    @cart = @current_cart
    @order.update(user_id: @current_user.id)

  end

  def destroy
    @cart = @current_cart
    @order.update(user_id: @current_user.id)
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  private

  # Never trust parameters from the scary internet
  # , only allow the white list through.
  def cart_params
    params.require(:cart).permit(:user_id)
  end

end
