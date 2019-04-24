class RegistrationsController < DeviseInvitable::RegistrationsController
  # layout 'organizations_layout', only: [:edit, :update]

  def create

  end

  protected

  def update_resource(resource, params)
    (params[:password].blank? && params[:password_confirmation].blank?) ? resource.update_without_password(params) : resource.update_attributes(params)
  end

end
