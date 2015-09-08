class AdminUsersController < ApplicationController

  layout 'admin'
  before_action :confirm_logged_in

  def index
    @users = AdminUser.sorted
  end

  def new
  end

  def create
    @user = AdminUser.new(user_params)
    if @user.valid?
      if @user.save
        flash[:notice] = 'User created successfully'
        redirect_to action: :index
      else
        flash[:notice] = 'Problem saving user.'
        render :new
      end
    else
      flash[:notice] = 'User is not valid.'
      render :new
    end
  end

  def edit
    @user = AdminUser.find params[:id]
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end

