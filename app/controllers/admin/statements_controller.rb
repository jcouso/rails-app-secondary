class Admin::StatementsController < ApplicationController

  def index
    @bids = current_user.my_bids_closed
  end
end
