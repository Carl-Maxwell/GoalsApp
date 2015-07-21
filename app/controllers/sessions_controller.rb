class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      user_params[:username],
      user_params[:password]
    )

    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid login!"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
