class ApplicationController < ActionController::Base
  include ApplicationHelper
  # protect_from_forgery with: :null_session
  # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery unless: -> { request.format.json? || request.request_method == "OPTIONS" }

  include SessionsHelper

  include CorsHelper
  before_action :cors_set_access_control_headers
  before_action :cors_preflight_check
  before_filter :store_location

  acts_as_token_authentication_handler_for User, if: :is_valid_cors_request?
  before_action :authenticate_user!, unless: :is_valid_cors_request?

  # skip_before_filter :verify_authenticity_token
  # protect_from_forgery prepend: true, with: :exception
  # before_action :set_bug, only: [:show, :edit, :update]
  # before_action :set_cart

  after_action :set_vary


  private

  def set_vary
    response.headers['Vary'] = 'Accept'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:first_name, :last_name]
    devise_parameter_sanitizer.permit :account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation]
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

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" && \
          request.fullpath != "/users/sign_up" && \
          request.fullpath != "/users/password" && \
          !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end


  def after_sign_in_path_for(resource)
    session.delete(:redirect_to) || session.delete(:previous_url) || root_path
  end

  # TODO: review what this does
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      respond_to do |format|
        format.json { render json: { errors: [exception.message] }, status: 403 }
        format.html {
          if !current_user.active?
            redirect_to '/users/sign_out?notice=true'
          elsif request.env['HTTP_REFERER'].present?
            redirect_to :back, alert: exception.message
          else
            redirect_to root_url, alert: exception.message
          end
        }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Please refresh page.' }, status: 401 }
        format.html { redirect_to new_user_session_path(redirect_to: request.original_url) }
      end
    end
  end


end
