class SessionsController < ApplicationController
  before_action :require_no_user, only: [:create, :new]

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user.nil?
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = ["No user with that username"]
      render :new
    elsif @user.authenticate(params[:user][:password])
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect password"]
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
