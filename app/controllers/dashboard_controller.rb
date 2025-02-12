class DashboardController < ApplicationController
  before_action :authenticate_user!
    def index
    @user=current_user
    end

    def update_icon
      if current_user.update(icon_params)
        redirect_to dashboard_path, notice: "Icon updated successfully!"
      else
        redirect_to dashboard_path, alert: "Failed to update icon."
      end
    end
  def update
    authorize_user!
    if @user.update(user_params)
      redirect_to dashboard_path, notice: "Profile updated successfully."
    else
      flash[:alert] = "Update failed: #{@user.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    redirect_to dashboard_path, alert: "Access denied!" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :dob, :gender, :email,:icon)
  end
  def icon_params
    params.require(:user).permit(:icon)
  end
  def edit
    authorize_user!
  end
end
