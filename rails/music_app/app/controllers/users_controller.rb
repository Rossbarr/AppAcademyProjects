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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
