class User::ConfirmationsController < Devise::ConfirmationsController

  # confirmation_tokenはdigest化されている
  def show
    self.resource = resource_class.find_by_digested_confirm_token(params[:confirmation_token])
    super if resource.nil? or resource.confirmed?
  end

  def confirm

    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    permits = params.require(resource_name).permit(:password, :password_confirmation)
    original_token = params[:frendly_token]

    if resource.update_attributes(permits) && resource.password_match?
      self.resource = resource_class.confirm_by_token(original_token)
      set_flash_message :notice, :confirmed

      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end
  
  private
  def strong_params
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:user_info => [:name])
    }
  end
end