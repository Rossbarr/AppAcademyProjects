class ApplicationController < ActionController::Base
  helper_method: current_user

  def current_user
    @current_user ||= SessionToken.find_by(session_token: sessions[:session_token]).user
  end
end
