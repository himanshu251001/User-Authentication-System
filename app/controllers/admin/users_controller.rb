class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_user, only: [ :edit, :update, :destroy ]


  def new
    @user = User.new
  end


  def create
    @user = User.new(admin_params)
  
    if @user.save
      redirect_to admin_dashboard_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_dashboard_path, notice: "User updated successfully."
    else
      render :edit
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end
  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :dob, :gender, :role)
  end
  def admin_params
    params.require(:user).permit(:email, :first_name, :last_name, :dob, :gender, :password, :password_confirmation, :role)
  end
end
