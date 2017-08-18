class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :set_security, only: [:show]
  layout "landing-page", only: [ :index ]
  def index
    @securities = policy_scope(Security)
  end

  def show
  end

  def search
    @securities = policy_scope(Security)
    authorize @securities
    if params[:price].present? || params[:maturity].present?
      if params[:price].blank?
        @securities = Security.where(maturity: params[:maturity])
      elsif params[:maturity].blank?
        @securities = Security.where(price: params[:price])
      else
        @securities = Security.where(maturity: params[:maturity], price: params[:price])
      end
    else
      @securities = policy_scope(Security).order("created_at DESC").limit(3)
    end
  end

  private

  def set_security
    @security = current_user.securities.find(params[:id])
    authorize @security
  end
end
