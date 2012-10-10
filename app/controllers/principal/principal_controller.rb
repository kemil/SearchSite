class Principal::PrincipalController < ActionController::Base
  protect_from_forgery
  layout 'principal-section'

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to new_user_session_path
  end

end