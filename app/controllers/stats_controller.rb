class StatsController < ApplicationController
  respond_to :html, :json
  before_filter :admin_user
  # GET /patients
  # GET /patients.json
  def index
    @stats = Stat.all
    @statsu = Stat.where(calculation_id: params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats }
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @stats = Stat.all
    @statsu = Stat.where(calculation_id: params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stat }
    end
  end

  
end


private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_path, notice: "Please sign in!"
  end
end