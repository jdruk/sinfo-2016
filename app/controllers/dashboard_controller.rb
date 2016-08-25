class DashboardController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :index
  
  def index
    puts "\n\n\n\n\n\n\n\ndasbboard------------------------\n"
    puts params[:transaction_id]
  end

  def admininstrator
  end
end
