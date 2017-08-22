class Admin::StatementsController < ApplicationController

  def index
    @bids = current_user.securities.map{|s| s.bids }.flatten.select{|b| b.status}
  end
end
