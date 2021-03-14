class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]

  def new
    @user = User.new()
    render :new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    
    if @user.nil?
      flash.now[:errors] = ["Could not find user with that email"]
      @user = User.new(email: params[:user][:email])
      render :new
    elsif @user.authenticate(params[:user][:password])
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Incorrect password"]
      render :new
    end
  end

  def destroy(token = session[:session_token])
    session_token = SessionToken.find_by(session_token: token)
    if session_token.destroy
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end
end
