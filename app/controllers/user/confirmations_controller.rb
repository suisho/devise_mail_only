class User::ConfirmationsController < Devise::ConfirmationsController


  def show
    self.resource = resource_class.find_by_digested_confirm_token(params[:confirmation_token])
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    p = params.require(resource_name).permit(:password, :password_confirmation)
    if resource.update_attributes(p) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end

end