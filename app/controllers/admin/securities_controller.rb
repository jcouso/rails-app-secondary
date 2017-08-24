class Admin::SecuritiesController < ApplicationController
before_action :set_security, only: [:edit, :update, :destroy, :show]
  def index
    @securities = Security.all.where(user: current_user)

  end

  def new
    @security = Security.new
  end

  def create
    @security = current_user.securities.new(security_params)
    if @security.save
      redirect_to admin_securities_path
    else
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update
    if @security.update(security_params)
      redirect_to admin_securities_path
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
  end

  def security_params
    params.require(:security).permit(:mode, :security_type_id, :issuer_id, :code, :issue_date, :maturity, :price, :date_limit, :status, :quantity, :rate, :indexer, :unit_price)
  end
end
