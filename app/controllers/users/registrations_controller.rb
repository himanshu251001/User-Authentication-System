class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def update_resource(resource, params)
      params.except!(:password, :password_confirmation) if params[:password].blank?
      resource.update_without_password(params)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email dob gender icon])
    end
end
