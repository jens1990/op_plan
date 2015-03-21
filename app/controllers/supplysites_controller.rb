class SupplysitesController < ApplicationController

  before_filter :signed_in_user


  # GET /supplysites
  # GET /supplysites.json
  def index
    @supplysites = Supplysite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @supplysites }
    end
  end

  # GET /supplysites/1
  # GET /supplysites/1.json
  def show
    @supplysite = Supplysite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supplysite }
    end
  end

  # GET /supplysites/new
  # GET /supplysites/new.json
  def new
    @supplysite = Supplysite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplysite }
    end
  end

  # GET /supplysites/1/edit
  def edit
    @supplysite = Supplysite.find(params[:id])
  end

  # POST /supplysites
  # POST /supplysites.json
  def create
    @supplysite = Supplysite.new(params[:supplysite])

    respond_to do |format|
      if @supplysite.save
        format.html { redirect_to @supplysite, notice: 'Angebotsort wurde erfolgreich angelegt.' }
        format.json { render json: @supplysite, status: :created, location: @supplysite }
      else
        format.html { render action: "new" }
        format.json { render json: @supplysite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /supplysites/1
  # PUT /supplysites/1.json
  def update
    @supplysite = Supplysite.find(params[:id])

    respond_to do |format|
      if @supplysite.update_attributes(params[:supplysite])
        format.html { redirect_to @supplysite, notice: 'Angebotsort wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @supplysite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplysites/1
  # DELETE /supplysites/1.json
  def destroy
    @supplysite = Supplysite.find(params[:id])
    @supplysite.destroy

    respond_to do |format|
      format.html { redirect_to supplysites_url }
      format.json { head :no_content }
    end
  end
end


private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_path, notice: "Bitte melden Sie sich an."
  end
end