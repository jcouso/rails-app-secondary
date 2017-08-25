class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_notifications
  before_action :configure_permitted_parameters, if: :devise_controller?


  def set_notifications
    @notifications = current_user.my_bids_all if user_signed_in?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :birthdate, :mother_name, :father_name, :address, :phone, :bank, :account_agency, :account_number, :document_type, :expedition_date, :document_number])
  end

end
