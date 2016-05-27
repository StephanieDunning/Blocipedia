class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Blocipedia #{@user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
  end

  def downgrade
    if current_user.downgrade
      flash[:notice] = "You're account is now standard."
      redirect_to root_path
    else
      flash[:notice] = "Something went wrong. Please try again."
      redirect_to edit_user_registration_path
    end
  end
end
