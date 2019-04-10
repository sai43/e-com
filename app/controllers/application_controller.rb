class ApplicationController < ActionController::Base
  include ApplicationHelper
  # protect_from_forgery with: :null_session
  # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery unless: -> { request.format.json? || request.request_method == "OPTIONS" }

  include SessionsHelper

  # include CorsHelper
  # before_action :cors_set_access_control_headers
  # before_action :cors_preflight_check

  # skip_before_filter :verify_authenticity_token
  # protect_from_forgery prepend: true, with: :exception
  # before_action :authenticate_user!
  # before_action :set_bug, only: [:show, :edit, :update]
  # before_action :set_cart

  private

  def set_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      cart.present? ? (@current_cart = cart) : (session[:cart_id] = nil)
    end
    return unless session[:cart_id].nil?

    @current_cart = Cart.create(user_id: nil)
    session[:cart_id] = @current_cart.id
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  def user_is_admin
    return if logged_in? && current_user.admin?

    flash[:info] = "You don't have the privilages for this action!"
    redirect_back(fallback_location: root_url)
  end
end
