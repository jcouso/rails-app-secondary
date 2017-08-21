class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :set_security, only: [:show, :calculate]
  layout "landing-page", only: [ :index ]
  def index
    @securities = Security.all
  end

  def show
    @bid = Bid.new
  end

  def search
    @securities = Security.all.order("created_at DESC")
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

  def calculate
    @bid = Bid.new

    if params[:bid_calculation][:mode] == "price"
      @bid.price = params[:bid_calculation][:price]
    else
      @bid.rate = params[:bid_calculation][:rate]
    end
  end

  private

    def set_security
      @security = Security.find(params[:id])
  end
end
