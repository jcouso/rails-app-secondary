class Admin::BidsController < ApplicationController
  def index
    @security = Security.find(params[:security_id])
    @bids = policy_scope(@security.bids).order(price: :desc)
  end

  def update
    @security = Security.find(params[:security_id])
    @bid = Bid.find(params[:id])
    @bid.status = true
    @security.status = @bid
    @bid.save!
    @security.save!
    redirect_to admin_security_bids_path
  end

  def mybids
    @securities = Bid.where(buyer: current_user).map(&:security).uniq
  end
end
