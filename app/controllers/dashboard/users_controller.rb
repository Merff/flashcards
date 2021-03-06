class Dashboard::UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
      if @user.save
        auto_login(@user)
        redirect_to @user, notice: (t '.notice')
      else
        render action: 'new' 
      end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: (t '.notice')
    else
      render action: 'edit' 
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :deck_id, :locale)
    end
end
