class Admin::BidsController < ApplicationController
  def index
    @security = Security.find(params[:security_id])
    @bids = @security.bids.order(price: :desc)
    @bid = @security.bids.where(status: true)
  end

  def create
    @security = Security.find(params[:security_id])
    @bid = Bid.create_attributes
    @bid.security = @security
  end

  def update
    @security = Security.find(params[:security_id])
    @bid = Bid.find(params[:id])
    if current_user == @security.user
      @bid.status = true
      @security.status = @bid
      @bid.save!
      @security.save!
      redirect_to admin_security_bids_path
    else
      redirect_to admin_security_bids_path
    end
  end

  def destroy

      @security  = Security.find(params[:security_id])
      @bid = @security.bids.find(params[:id])
    if current_user == @security.user
      @bid.destroy
      redirect_to admin_security_bids_path
    end
  end

  def mybids
    @securities = Bid.where(buyer: current_user).map(&:security).uniq
  end

end
