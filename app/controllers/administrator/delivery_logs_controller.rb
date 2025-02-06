class Administrator::DeliveryLogsController < ApplicationController
  before_action :authenticate_administrator!

  def index
    
  end

  def create
    @delivery_log = DeliveryLog.new delivery_logs_params

    respond_to do |format|
      if @delivery_log.save
        format.turbo_stream
      end
    end
  end

  def new

  end

  private

  def delivery_logs_params
    params.require(:delivery_log)
      .permit(:order_id, :description)
  end
end
