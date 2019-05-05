class Api::V1::OrdersController < ApplicationController
  # before_action :logged_in_user, only: %i[index show new create]
  # before_action :user_is_admin, only: %i[destroy edit]
  # before_action :cart_is_empty, only: %i[new create]

  def index
    @orders = current_user.orders
    json_response @orders
  end

  def show
    @order = Order.find(params[:id])
    json_response @order
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    # @order = Order.new(order_params)
    # @order.update(user_id: current_user.id)
    # add_line_items_to_order
    # @order.save!
    # # reset_sessions_cart
    # json_response @order

    order = Order.new
    cart = Cart.new
    line_item = LineItem.new

    user = User.find(current_user)
    product = Product.find(params[:product_id])

    order.user_id = user.id
    order.save!

    cart.user_id = user.id
    cart.save!

    line_item.quantity = params[:quantity]
    line_item.order_id = order.id
    line_item.cart_id = cart.id
    line_item.product_id = product.id
    line_item.save!
    json_response order
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    json_response ( head :no_content )

  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    json_response @order
  end

  def cart_is_empty
    return unless @current_cart.line_items.empty?
    store_location
    flash[:danger] = 'You cart is empty!'
  end

  private

  def add_line_items_to_order
    @current_cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = @order.id
      item.save
      @order.line_items << item
    end
  end

  def reset_sessions_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(:user_id, :pay_method, :description)
  end

end
