class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_user, only: [:edit, :update]

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
end
