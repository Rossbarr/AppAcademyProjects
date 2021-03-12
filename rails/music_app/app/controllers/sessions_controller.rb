class SessionsController < ApplicationController
  def new
    @user = User.new()
    render :new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    
    if @user.authenticate(params[:user][:password])
      SessionToken.new(user_id: @user.id)
    #  redirect_to
    elsif @user.nil?
      flash.now[:errors] = "Could not find user with that email"
      @user = User.new(email: params[:user][:email])
      render :new
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    session_token = SessionToken.find_by(session_token: session[:session_token])
    if session_token.destroy
      # redirect_to
    end
  end
end
