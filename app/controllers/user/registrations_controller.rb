class User::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end
 
  def create
    super
  end
  
  private
  def strong_params
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:user_info => [:name])
    }
  end
end