class User::ConfirmationsController < Devise::ConfirmationsController

  # confirmation_tokenはdigest化されている
  def show
    self.resource = resource_class.find_by_digested_confirm_token(params[:confirmation_token])
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    permits = params.require(resource_name).permit(:password, :password_confirmation)
    if resource.update_attributes(permits) && resource.password_match?
      token = resource_class.digest_confirmation_token(params[resource_name][:confirmation_token])
      self.resource = resource_class.confirm_by_token(token)
      raise
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end

end