class ProductMachinesController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user
  # GET /product_machines
  # GET /product_machines.json
  def index
    @product_machines = ProductMachine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_machines }
    end
  end

  # GET /product_machines/1
  # GET /product_machines/1.json
  def show
    @product_machine = ProductMachine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_machine }
    end
  end

  # GET /product_machines/new
  # GET /product_machines/new.json
    def new
      @product_machine = ProductMachine.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @product_machine }
      end
    end

  # GET /product_machines/1/edit
  def edit
    @product_machine = ProductMachine.find(params[:id])
  end

  # POST /product_machines
  # POST /product_machines.json
    def create
      @product_machine = ProductMachine.new(params[:product_machine])

      respond_to do |format|
        if @product_machine.save
          format.html { redirect_to @product_machine, notice: 'Produkt wurde erfolgreich angelegt!' }
          format.json { render json: @product_machine, status: :created, location: @product_machine }
        else
          format.html { render action: "new" }
          format.json { render json: @product_machine.errors, status: :unprocessable_entity }
        end
      end
    end

  # PUT /product_machines/1
  # PUT /product_machines/1.json
  def update
    @product_machine = ProductMachine.find(params[:id])

    respond_to do |format|
      if @product_machine.update_attributes(params[:product_machine])
        format.html { redirect_to @product_machine, notice: 'Produkt-Maschine-Relation wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_machines/1
  # DELETE /product_machines/1.json
    def destroy
      @product_machine = ProductMachine.find(params[:id])
      @product_machine.destroy

     respond_to do |format|
       format.html { redirect_to product_machines_url }
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