class LogsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        render :index
      end

      format.json do
        logs = Log.by_timestamp.limit(50)
        render json: logs
      end
    end
  end
end
