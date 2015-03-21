class DemandsitesController < ApplicationController

  before_filter :signed_in_user

  # GET /demandsites
  # GET /demandsites.json
  def index
    @demandsites = Demandsite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demandsites }
    end
  end

  # GET /demandsites/1
  # GET /demandsites/1.json
  def show
    @demandsite = Demandsite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @demandsite }
    end
  end

  # GET /demandsites/new
  # GET /demandsites/new.json
  def new
    @demandsite = Demandsite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @demandsite }
    end
  end

  # GET /demandsites/1/edit
  def edit
    @demandsite = Demandsite.find(params[:id])
  end

  # POST /demandsites
  # POST /demandsites.json
  def create
    @demandsite = Demandsite.new(params[:demandsite])

    respond_to do |format|
      if @demandsite.save
        format.html { redirect_to @demandsite, notice: 'Nachfrageort wurde erfolgreich angelegt.' }
        format.json { render json: @demandsite, status: :created, location: @demandsite }
      else
        format.html { render action: "new" }
        format.json { render json: @demandsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /demandsites/1
  # PUT /demandsites/1.json
  def update
    @demandsite = Demandsite.find(params[:id])

    respond_to do |format|
      if @demandsite.update_attributes(params[:demandsite])
        format.html { redirect_to @demandsite, notice: 'Nachfrageort wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @demandsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demandsites/1
  # DELETE /demandsites/1.json
  def destroy
    @demandsite = Demandsite.find(params[:id])
    @demandsite.destroy

    respond_to do |format|
      format.html { redirect_to demandsites_url }
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