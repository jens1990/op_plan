class PeriodsController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user
  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.all
    @number_of_periods = Period.count
    if @mynumber_of_periods = nil
      @mynumber_of_periods=@number_of_periods
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @periods }
    end
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @period = Period.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @period }
    end
  end

  def change
    @mynumber_of_periods = params[:mynewnumber].to_i
    @number_of_periods = Period.count
    number_of_missing_periods=@mynumber_of_periods - @number_of_periods

    if number_of_missing_periods > 0
      @products = Product.all
      @machines = Machine.all
      (1..number_of_missing_periods).each do |number|
        name="#{number+@number_of_periods}"
        @new_period=Period.create!(name: name)
        @products.each { |pr|
          ProductPeriod.create(product_id: pr.id, period_id: @new_period.id, demand: 0)
        }
        @machines.each { |ma|
          MachinePeriod.create(machine_id: ma.id, period_id: @new_period.id, capacity: 0, overtime: 0)
        }
      end
    end

    if number_of_missing_periods < 0
      (@mynumber_of_periods +1 ..@number_of_periods).each do |number|
        name="#{number}"
        Period.find_by_name(name).destroy
      end
    end


    @periods = Period.all
    render :template => "periods/index"

  end

  # GET /periods/new
  # GET /periods/new.json
  def new
    @period = Period.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @period }
    end
  end

  # GET /periods/1/edit
  def edit
    @period = Period.find(params[:id])
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(params[:period])

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Produkt wurde erfolgreich angelegt!' }
        format.json { render json: @period, status: :created, location: @period }
      else
        format.html { render action: "new" }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /periods/1
  # PUT /periods/1.json
  def update
    @period = Period.find(params[:id])

    respond_to do |format|
      if @period.update_attributes(params[:period])
        format.html { redirect_to @period, notice: 'Produkt   wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period = Period.find(params[:id])
    @period.destroy

    respond_to do |format|
      format.html { redirect_to periods_url }
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