class CalculationsController < ApplicationController
 # respond_to :html, :json
  before_filter :admin_user
  # GET /calculations
  # GET /calculations.json
  def index
    @calculations = Calculation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calculations }
    end
  end

  # GET /calculations/1
  # GET /calculations/1.json
  def show
    @calculation = Calculation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calculation }
    end
  end

  # GET /calculations/new
  # GET /calculations/new.json
  def new
    @calculation = Calculation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calculation }
    end
  end

  # GET /calculations/1/edit
  def edit
    @calculation = Calculation.find(params[:id])
  end

  # POST /calculations
  # POST /calculations.json
  def create
    @calculation = Calculation.new(params[:calculation])

    respond_to do |format|
      if @calculation.save
        format.html { redirect_to @calculation, notice: 'Calculation created!' }
        format.json { render json: @calculation, status: :created, location: @calculation }
      else
        format.html { render action: "new" }
        format.json { render json: @calculation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calculations/1
  # PUT /calculations/1.json
  def update
    @calculation = Calculation.find(params[:id])

    respond_to do |format|
      if @calculation.update_attributes(params[:calculation])
        format.html { redirect_to @calculation, notice: 'Calculation updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calculation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculations/1
  # DELETE /calculations/1.json
  def destroy
    @calculation = Calculation.find(params[:id])
    @calculation.destroy

    respond_to do |format|
      format.html { redirect_to calculations_url }
      format.json { head :no_content }
    end
  end

  def erase_calculations
    if File.exist?("Saalzuordnung.txt")
      File.delete("Saalzuordnung.txt")
    end
    Calculation.destroy_all

    redirect_to calculations_path
  end


  #Befehl zum automatischen Befuellen der leeren Calculation Spalten

  def aggregate
    calc_id = Calculation.find(params[:id]).id
    # loeschen alter Werte
    Demand0.where(calculation_id:  calc_id).delete_all
    Demand1.where(calculation_id:  calc_id).delete_all
    Demand2.where(calculation_id:  calc_id).delete_all
    @specialty = Specialty.all

    #if Demand0.where(calculation_id: calc_id).empty?
      
    dem_mon = 0
    dem_tue = 0
    dem_wed = 0
    dem_thu = 0
    dem_fri = 0

#   Fuer alle Specialties summiere die OP Zeiten der Patienten Typ 0 
      @specialty.each do |n|
        dem_mon = Patient.where(:specialty_id => [Specialty.find(n).id]).where(:startday_of_stay =>'Mon').where(:type_of_patient =>'0').sum(:op_time)
        dem_tue = Patient.where(:specialty_id => [Specialty.find(n).id]).where(:startday_of_stay =>'Tue').where(:type_of_patient =>'0').sum(:op_time)
        dem_wed = Patient.where(:specialty_id => [Specialty.find(n).id]).where(:startday_of_stay =>'Wed').where(:type_of_patient =>'0').sum(:op_time)
        dem_thu = Patient.where(:specialty_id => [Specialty.find(n).id]).where(:startday_of_stay =>'Thu').where(:type_of_patient =>'0').sum(:op_time)
        dem_fri = Patient.where(:specialty_id => [Specialty.find(n).id]).where(:startday_of_stay =>'Fri').where(:type_of_patient =>'0').sum(:op_time)
        Demand0.create!(calculation_id: calc_id, specialty_id: Specialty.find(n).id, Mon: dem_mon, Tue: dem_tue, Wed: dem_wed, Thu: dem_thu, Fri: dem_fri)
        end

      @specialty.each do |m|
        dem_mon = Patient.where(:specialty_id => [Specialty.find(m).id]).where(:startday_of_stay =>'Mon').where(:type_of_patient =>'1').sum(:op_time)
        dem_tue = Patient.where(:specialty_id => [Specialty.find(m).id]).where(:startday_of_stay =>'Tue').where(:type_of_patient =>'1').sum(:op_time)
        dem_wed = Patient.where(:specialty_id => [Specialty.find(m).id]).where(:startday_of_stay =>'Wed').where(:type_of_patient =>'1').sum(:op_time)
        dem_thu = Patient.where(:specialty_id => [Specialty.find(m).id]).where(:startday_of_stay =>'Thu').where(:type_of_patient =>'1').sum(:op_time)
        dem_fri = Patient.where(:specialty_id => [Specialty.find(m).id]).where(:startday_of_stay =>'Fri').where(:type_of_patient =>'1').sum(:op_time)
        Demand1.create!(calculation_id: calc_id, specialty_id: Specialty.find(m).id, Mon: dem_mon, Tue: dem_tue, Wed: dem_wed, Thu: dem_thu, Fri: dem_fri)
        end

      @specialty.each do |o|
        dem_mon = Patient.where(:specialty_id => [Specialty.find(o).id]).where(:startday_of_stay =>'Mon').where(:type_of_patient =>'2').sum(:op_time)
        dem_tue = Patient.where(:specialty_id => [Specialty.find(o).id]).where(:startday_of_stay =>'Tue').where(:type_of_patient =>'2').sum(:op_time)
        dem_wed = Patient.where(:specialty_id => [Specialty.find(o).id]).where(:startday_of_stay =>'Wed').where(:type_of_patient =>'2').sum(:op_time)
        dem_thu = Patient.where(:specialty_id => [Specialty.find(o).id]).where(:startday_of_stay =>'Thu').where(:type_of_patient =>'2').sum(:op_time)
        dem_fri = Patient.where(:specialty_id => [Specialty.find(o).id]).where(:startday_of_stay =>'Fri').where(:type_of_patient =>'2').sum(:op_time)
        Demand2.create!(calculation_id: calc_id, specialty_id: Specialty.find(o).id, Mon: dem_mon, Tue: dem_tue, Wed: dem_wed, Thu: dem_thu, Fri: dem_fri)
      end

      flash[:started] = "Demands calculated!"
      redirect_to calculations_path
   # else
   #   flash[:not_available] = "Demands already aggregated!"
   #   redirect_to calculations_path
   # end
  end

end


private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in!"
    end
   end
