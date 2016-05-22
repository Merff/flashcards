class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:users, notice: (t '.notice'))
    else
      flash.now[:alert] = (t '.alert')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to new_user_path, notice: (t '.notice')
  end
end
