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

  def search
    @securities = policy_scope(Security).order("created_at DESC")
    authorize @securities
    @search = Search.new

    if params[:search].present?
      @search.price = params[:search][:price]
      @search.maturity = params[:search][:maturity]
    end

    if @search.maturity.present?
      date = @search.maturity + "-12-31"
      @securities = @securities.where("maturity <= ?", date)
    end

    if @search.price.present?
      @securities = @securities.where("unit_price * quantity <= ?", @search.price)
    end
  end


  private

  def set_security
    @security = current_user.securities.find(params[:price, :maturity])
    authorize @security
  end
end
