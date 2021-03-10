class SessionsController < ApplicationController
  before_action :require_no_user, only: [:create, :new]

  def create
    @user = User.find_by_credentials(
      params[:user][:username], 
      params[:user][:password]
    )

    if @user
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
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
