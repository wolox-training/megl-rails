class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { api_request? }

  def access_denied
    reset_session
    flash[:notice] = "You don't have permissions for this action."
    redirect_to new_admin_user_session_path
  end

  private

  def api_request?
    controller_path.include? 'devise_token_auth'
  end
end
