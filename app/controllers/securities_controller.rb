class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :set_security, only: [:show]
  layout "landing-page", only: [ :index ]
  def index
    @securities = policy_scope(Security)
  end

  def show
    @bid = Bid.new
  end


  private

  def set_security
    @security = current_user.securities.find(params[:id])
    authorize @security
  end
end
