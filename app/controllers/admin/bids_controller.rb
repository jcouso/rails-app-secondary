class Admin::BidsController < ApplicationController
  def index
    @restaurants = policy_scope(Bid).order(created_at: :desc)
  end

  def mybids
  end
end
