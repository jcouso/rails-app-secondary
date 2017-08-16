class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  layout "landing-page", only: [ :index, :search ]

  def index
    @securities = policy_scope(Security)
  end

  def search
    @securities = Security.all.order(created_at: :desc)
    authorize @securities
  end
end
