class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :set_security, only: [:show]
  layout "landing-page", only: [:index, :search]

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
      @search.security_type_id = params[:search][:security_type_id]
      @search.price = params[:search][:price]
      @search.maturity = params[:search][:maturity]
      @search.issuer_id = params[:search][:issuer_id]
      @search.rate = params[:search][:rate]
    end

    if @search.security_type_id.present?
      @securities = @securities.where(security_type_id: @search.security_type_id)
    end

    if @search.maturity.present?
      @securities = @securities.where("maturity <= ?", @search.maturity)
    end

    if @search.price.present?
      @securities = @securities.where("unit_price * quantity <= ?", @search.price)
    end

    if @search.issuer_id.present?
      @securities = @securities.where(issuer_id: @search.issuer_id)
    end

    if @search.rate.present?
      @securities =@securities.where("rate >=?", @search.rate)
    end
  end


  private

    def set_security
        @security = Security.find(params[:id])
        authorize @security
    end
end
