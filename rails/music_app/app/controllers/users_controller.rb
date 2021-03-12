class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      SessionToken.create(user_id: @user.id)
      sessions[:session_token] = 
    else
      flash.new[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      redirect_to :new_session_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
