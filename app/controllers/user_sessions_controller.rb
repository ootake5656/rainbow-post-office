class UserSessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    if login(params[:email], params[:password])
      redirect_to root_path
    else
      @email = params[:email]
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
