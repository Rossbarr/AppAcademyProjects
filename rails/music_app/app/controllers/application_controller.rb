class ApplicationController < ActionController::Base
  helper_method :current_user, :login!, :require_user!, :require_no_user!

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= SessionToken.find_by(session_token: session[:session_token]).try(:user)
  end

  def login!(user)
    session_token = SessionToken.new(user_id: @user.id)
    session_token.regenerate_session_token
    session[:session_token] = session_token.session_token
  end

  def require_user!
    if current_user.nil?
      redirect_to new_session_url
    end
  end

  def require_no_user!
    if !current_user.nil?
      redirect_to user_url(current_user)
    end
  end
end
