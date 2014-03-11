class UserMailConfirmations::ConfirmationsController < Devise::ConfirmationsController
  def create
    new_resource = resource_class.send_confirmation_instructions(resource_params)
    new_resource.save!
    super
  end
  
  def show
  end

  protected
  def after_confirmation_path_for
    user_mail_confirmation_confirmation_path
  end

  
end