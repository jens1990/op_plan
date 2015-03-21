class Demand0sController < ApplicationController
 # respond_to :html, :json
  before_filter :signed_in_user
  # GET /demands
  # GET /demands.json
  def index
    @demand0 = Demand0.where(calculation_id: params[:id])
    @demand1 = Demand1.where(calculation_id: params[:id])
    @demand2 = Demand2.where(calculation_id: params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demands }
    end
  end

  # GET /demands/1
  # GET /demands/1.json
  def show
    @demand0 = Demand0.where(calculation_id: params[:id])
    @demand1 = Demand1.where(calculation_id: params[:id])
    @demand2 = Demand2.where(calculation_id: params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @demand0 }
    end
  end

  # GET /demands/1/edit
  def edit
    @demand0 = Demand0.find(params[:id])
  end


  # PUT /demands/1
  # PUT /demands/1.json
  def update
    @demand0 = Demand0.find(params[:id])
    @demandS = Calculation.find(@demand0.calculation_id)

    respond_to do |format|
      if @demand0.update_attributes(params[:demand0])
        format.html { redirect_to demand0_path(@demandS), notice: 'Demands updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @demand0.errors, status: :unprocessable_entity }
      end
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
