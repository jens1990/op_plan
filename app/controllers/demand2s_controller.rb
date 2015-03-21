class Demand2sController < ApplicationController
 # respond_to :html, :json
  before_filter :signed_in_user
  # GET /demands
  # GET /demands.json
  
  def edit
    @demand2 = Demand2.find(params[:id])
  end


  # PUT /demands/1
  # PUT /demands/1.json
  def update
    @demand2 = Demand2.find(params[:id])
    @demandS = Calculation.find(@demand2.calculation_id)

    respond_to do |format|
      if @demand2.update_attributes(params[:demand2])
        format.html { redirect_to demand0_path(@demandS), notice: 'Demand updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @demand2.errors, status: :unprocessable_entity }
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
