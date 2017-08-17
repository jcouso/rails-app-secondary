class Admin::BidsController < ApplicationController
  def index
    @security = Security.find(params[:security_id])
    @bids = policy_scope(@security.bids).order(created_at: :desc)
  end

  def mybids
    @securities = Bid.where(buyer: current_user).map(&:security).uniq
  end
end
