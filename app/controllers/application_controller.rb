class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_notifications

  def set_notifications
    @notifications = current_user.my_bids_all if user_signed_in?
  end

end
