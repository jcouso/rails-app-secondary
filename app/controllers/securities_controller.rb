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
    @securities = Security.all.order("price ASC").where(status: nil)

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
      @securities = @securities.where("maturity <= ?", Date.parse(@search.maturity)).reorder("maturity ASC")
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

  def ajax_calculate
    sec = Security.new(params.permit(:issue_date, :maturity, :quantity, :unit_price, :rate, :indexer))
    respond_to do |format|
      format.json { render json: sec.current_value }
    end
  end

  def calculate
    @bid = Bid.new

    if params[:bid_calculation][:mode] == "price"
      @bid.price = params[:bid_calculation][:price]
      n = (@security.time_to_maturity.to_f) * (360.to_f/365)
      pv = @bid.price
      @bid.indexer = @security.indexer
      @bid.rate = ((((hp12c_fv.to_f / pv)**(1.to_f/n))**(360))-1)*100

      @calculation_price = true
    else
      @bid.rate = params[:bid_calculation][:rate]
      @bid.indexer = params[:bid_calculation][:indexer]
      n = (@security.time_to_maturity.to_f) * (360.to_f/365)
      i_dia = ((gross_profitability.to_f / 100)+1)**(1.to_f/360)
      @bid.price = (hp12c_fv.to_f / ((i_dia.to_f)**(n)))
      @calculation_price = false
    end
  end

  private

  def hp12c_fv
    n = (@security.time_to_maturity.to_f + @security.time_elapsed.to_f) * (360.to_f/365)
    pv = @security.value
    i_dia = ((@security.hp12c_interest.to_f / 100)+1)**(1.to_f/360)
    fv = pv.to_f * ((i_dia.to_f)**(n.to_f))
    fv
  end

    def gross_profitability
    indexer = @bid.indexer || @security.indexer
    if indexer == "PRE"
      @bid.rate.to_f
    elsif indexer == "CDI"
      @bid.rate.to_f * (@security.cdi.to_f/100)
    elsif indexer == "IPC-A+"
      @bid.rate.to_f + @security.ipca
    elsif indexer == "IGP-M+"
      @bid.rate.to_f + @security.igpm
    end
  end

    def set_security
        @security = Security.find(params[:id])
    end

    def search_params
      if !params[:search].nil?
      params.require(:search).permit(:price, :maturity, :issuer_id, :rate, :indexer, :security_type_id, :file, :file_cache)
      end
    end
end
