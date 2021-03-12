class SessionsController < ApplicationController
  def create
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    
  end
end
