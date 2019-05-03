class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  include ApplicationHelper
  include SessionsHelper

  # protect_from_forgery with: :null_session
  # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery unless: -> { request.format.json? || request.request_method == "OPTIONS" }

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user
  # before_action :set_cart

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end


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
