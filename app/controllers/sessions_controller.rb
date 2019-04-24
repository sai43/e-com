class SessionsController < Devise::SessionsController
  # layout 'unauthorized'
  respond_to :html, :json
  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_action :authenticate_user!

  def new
    super do |resource|
      if params[:redirect_to].present?
        session[:redirect_to] = params[:redirect_to]
      end
    end
  end

  def create
    respond_to do |format|
      format.html { super }
      format.json {
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
        render :status => 200, :json => { :success => "true", :token => current_user.authentication_token }
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html { super }
      format.json {
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        render :json => {
            'csrfParam' => request_forgery_protection_token,
            'csrfToken' => form_authenticity_token
        }
      }
    end
  end

end

