class SecuritiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  def index
  end

end
