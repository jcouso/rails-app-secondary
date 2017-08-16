class Admin::SecuritiesController < ApplicationController
before_action :set_security, only: [:edit, :update, :destroy]
  def index
    @securities = policy_scope(Security).where(user: current_user)
  end

  def new
    @security = Security.new
    authorize @security
  end

  def create
    @security = current_user.securities.new(security_params)
    authorize @security
    if @security.save
      redirect_to admin_securities_path(@security)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @security.update(security_params)
      redirect_to admin_securities_path(@security)
    else
      render :edit
    end
  end

  def destroy
    @security.destroy
    redirect_to admin_securities_path
  end

  private

  def set_security
    @security = current_user.securities.find(params[:id])
    authorize @security
  end

  def security_params
    params.require(:security).permit(:mode, :security_type_id, :issuer_id, :code, :maturity, :price, :date_limit, :status, :quantity, :rate, :indexer, :unit_price)
  end

end
