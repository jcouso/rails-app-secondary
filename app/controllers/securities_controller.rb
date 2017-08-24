class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :set_security, only: [:show, :calculate]
  layout "landing-page", only: [ :index, :search ]
  def index
    @securities = Security.all
  end

  def show
    @bid = Bid.new
  end

  def search
    @search = Search.new(search_params)
    @securities = Security.all.order("price ASC")

    if params[:search].present?
      @search.security_type_id = params[:search][:security_type_id]
      @search.price = params[:search][:price]
      @search.maturity = params[:search][:maturity]
      @search.issuer_id = params[:search][:issuer_id]
      @search.rate = params[:search][:rate]
    end

    if @search.security_type_id.present?
      @securities = @securities.where(security_type_id: @search.security_type_id).reorder("price ASC")
    end

    if @search.maturity.present?
      @securities = @securities.where("maturity <= ?", @search.maturity).reorder("maturity ASC")
    end

    if @search.price.present?
      @securities = @securities.where("price <= ?", @search.price).reorder("price ASC")
    end

    if @search.issuer_id.present?
      @securities = @securities.where(issuer_id: @search.issuer_id).reorder("price ASC")
    end

    if @search.rate.present?
      @securities = @securities.where("rate >=?", @search.rate).reorder("rate DESC")
    end
  end

  def calculate
    @bid = Bid.new

    if params[:bid_calculation][:mode] == "price"
      @bid.price = params[:bid_calculation][:price]
    else
      @bid.rate = params[:bid_calculation][:rate]
      @bid.indexer = params[:bid_calculation][:indexer]
    end
  end

  private

    def set_security
        @security = Security.find(params[:id])
    end

    def search_params
      if !params[:search].nil?
      params.require(:search).permit(:price, :maturity, :issuer_id, :rate, :indexer, :security_type_id, :file, :file_cache)
      end
    end
end
