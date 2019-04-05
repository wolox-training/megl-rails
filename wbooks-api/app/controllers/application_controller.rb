class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def access_denied
    reset_session
    redirect_to new_admin_user_session_path
  end
end