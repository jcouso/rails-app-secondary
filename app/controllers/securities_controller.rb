class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  layout "landing-page", only: [ :index ]
  def index
    @securities = policy_scope(Security)
  end

end
