class MachinePeriodsController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user
  # GET /machine_periods
  # GET /machine_periods.json
  def index
    @machine_periods = MachinePeriod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @machine_periods }
    end
  end

  # GET /machine_periods/1
  # GET /machine_periods/1.json
  def show
    @machine_period = MachinePeriod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @machine_period }
    end
  end

  # GET /machine_periods/new
  # GET /machine_periods/new.json
  #  def new
  #    @machine_period = MachinePeriod.new

  #    respond_to do |format|
  #      format.html # new.html.erb
  #      format.json { render json: @machine_period }
  #    end
  #  end

  # GET /machine_periods/1/edit
  def edit
    @machine_period = MachinePeriod.find(params[:id])
  end

  # POST /machine_periods
  # POST /machine_periods.json
  #  def create
  #    @machine_period = MachinePeriod.new(params[:machine_period])

  #    respond_to do |format|
  #      if @machine_period.save
  #        format.html { redirect_to @machine_period, notice: 'Produkt wurde erfolgreich angelegt!' }
  #        format.json { render json: @machine_period, status: :created, location: @machine_period }
  #      else
  #        format.html { render action: "new" }
  #        format.json { render json: @machine_period.errors, status: :unprocessable_entity }
  #      end
  #    end
  #  end

  # PUT /machine_periods/1
  # PUT /machine_periods/1.json
  def update
    @machine_period = MachinePeriod.find(params[:id])

    respond_to do |format|
      if @machine_period.update_attributes(params[:machine_period])
        format.html { redirect_to @machine_period, notice: 'Produkt   wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @machine_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_periods/1
  # DELETE /machine_periods/1.json
  #  def destroy
  #    @machine_period = MachinePeriod.find(params[:id])
  #    @machine_period.destroy

  #   respond_to do |format|
  #     format.html { redirect_to machine_periods_url }
  #     format.json { head :no_content }
  #   end
  # end
end


private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_path, notice: "Bitte melden Sie sich an."
  end
end