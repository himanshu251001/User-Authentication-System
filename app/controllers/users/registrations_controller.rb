class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    before_action :configure_sign_up_params, only: [ :create ]





    protected





    def update_resource(resource, params)
      params.except!(:password, :password_confirmation) if params[:password].blank?

      resource.update_without_password(params)
    end



    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email dob gender icon])
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :email, :password, :password_confirmation, :dob, :gender, :icon ])
    end
end
