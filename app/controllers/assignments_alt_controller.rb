class AssignmentsController < ApplicationController
    before_filter :signed_in_user, only: :show
    before_filter :admin_user

    # GET /assignments
    # GET /assignments.json
    def index
      @assignments = Assignment.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @assignments }
      end
    end

    # GET /assignments/1
    # GET /assignments/1.json
    def show
    @assignment = Assignment.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @assignment }
      end
    end

    # GET /assignments/new
    # GET /assignments/new.json
    def new
      @assignment = Assignment.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @assignment }
      end
    end

    # GET /assignments/1/edit
    def edit
      @assignment = Assignment.find(params[:id])
    end

    # POST /assignments
    # POST /assignments.json
    def create
      @assignment = Assignment.new(params[:assignment])

      respond_to do |format|
        if @assignment.save
          format.html { redirect_to @assignment, notice: 'Zuordnung wurde erfolgreich angelegt!' }
          format.json { render json: @assignment, status: :created, location: @assignment }
        else
          format.html { render action: "new" }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /assignments/1
    # PUT /assignments/1.json
    def update
      @assignment = Assignment.find(params[:id])

      respond_to do |format|
        if @assignment.update_attributes(params[:assignment])
          format.html { redirect_to @assignment, notice: 'Zuordnung wurde erfolgreich aktualisiert.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        end
      end
    end



    # DELETE /assignments/1
    # DELETE /assignments/1.json
    def destroy
      @assignment = Assignment.find(params[:id])
      @assignment.destroy

      respond_to do |format|
        format.html { redirect_to assignments_url }
        format.json { head :no_content }
      end
    end

 #     def erase_assignments
 #     if File.exist?("Operationssaalzuordnung.txt")
 #     File.delete("Operationssaalzuordnung.txt")
 #     end
 #     if File.exist?("Seminar-Zielfunktionswert.txt")
 #       File.delete("Seminar-Zielfunktionswert.txt")
 #     end
 #     @assignments = Assignment.all
 #     @assignments.each { |li|
 #       li.assigned=false
 #       li.save
 #     }
 #     @objective_function_value=nil
 #     render :template => "assignments/index"
 #    end

    def optimize
      if File.exist?("Operationsplan_Input.inc")
        File.delete("Operationsplan_Input.inc")
      end
      f = File.new("Operationsplan_Input.inc", "w")

#Array-Definition
      days = Array.new
      days = ['Mon','Tue','Wed','Thu','Fri']

#Operationssäle
      printf(f, "sets i / \n")
      @operating_rooms = OperatingRoom.all
      @operating_rooms.each { |opr| printf(f, opr.name.to_s + "\n") }
      printf(f, "/" + "\n\n")

#Fachgebiete
      printf(f, "j / \n")
      @specialties = Specialty.all
      @specialties.each { |sp| printf(f, sp.name.to_s + "\n") }
      printf(f, "/" + "\n\n")

#Tage
      printf(f, "k / \n")
      days.each { |d| printf(f, d.to_s + " " + "\n") }
      printf(f, "/;" + "\n\n")

#Operationssaal-Fachgebiet-Relationen
      printf(f, "IJ(i,j) = no;\n\n")

      @room_specialty = RoomSpecialty.all
      @room_specialty.each do |opsp|
        printf(f, "IJ('")
        printf(f, opsp.operating_room.name.to_s)
        printf(f,"','")
        printf(f,opsp.specialty.name.to_s)
        printf(f,"') = yes;\n\n")
      end

      printf(f, "\n\n")
      printf(f, "parameters\n")

      printf(f, "a(i) /\n")
      @operating_rooms = OperatingRoom.all
      @operating_rooms.each { |opr| printf(f, opr.name.to_s + " " + opr.amount.to_s + "\n") }
      printf(f, "/" + "\n\n")

#Bestrafungsparameter
      printf(f, "tetaIPT /100/ \n")
      printf(f, "tetaOPT /100/ \n")
      printf(f, "Beta /0.5/ \n")

      printf(f, ";\n")

# Hier muss eingelesen werden
#Arbeitsstunden
      workh = Calculation.find(params[:id]).workhours_perDay.to_s
      printf(f, "scalar \n")
      printf(f, "s " + workh + "\n\n")

#Operationsnachfragen an den Tagen

#Notfall
     calcID = Calculation.find(params[:id]).id
     printf(f, "table \n")
     printf(f, "e(j,k) \n")
     printf(f, "\t\t")
     days.each { |d| printf(f,d.to_s + "\t\t") }
     printf(f, "\n")
     @demand_0 = Demand_0.where(:calculation_id => calcID)
     @demand_0.each do |em|
      @specialty = Specialty.where(id: em.specialty_id)
        @specialty.each do |sp|
          printf(f, sp.name.to_s + "\t")
          printf(f, em.Mon.to_s + "\t" + em.Tue.to_s + "\t" + em.Wed.to_s + "\t" + em.Thu.to_s + "\t" + em.Fri.to_s + "\n")
        end
        printf(f, "\n")
      end
    printf(f, "\n")


#Stationär
      printf(f, "table \n")
      printf(f, "n(j,k) \n")
      printf(f, "\t\t")
      days.each { |d| printf(f,d.to_s + "\t\t") }
      printf(f, "\n")
      @demand_1 = Demand_1.where(:calculation_id => calcID)
      @demand_1.each do |st|
        @specialty = Specialty.where(id: st.specialty_id)
        @specialty.each do |sp|
          printf(f, sp.name.to_s + "\t")
          printf(f, st.Mon.to_s + "\t" + st.Tue.to_s + "\t" + st.Wed.to_s + "\t" + st.Thu.to_s + "\t" + st.Fri.to_s + "\n")
        end
        printf(f, "\n")
      end
      printf(f, "\n")

#Ambulant
      printf(f, "table \n")
      printf(f, "o(j,k) \n")
      printf(f, "\t\t")
      days.each { |d| printf(f,d.to_s + "\t\t") }
      printf(f, "\n")
      @demand_2 = Demand_2.where(:calculation_id => calcID)
      @demand_2.each do |am|
        @specialty = Specialty.where(id: am.specialty_id)
        @specialty.each do |sp|
          printf(f, sp.name.to_s + "\t")
          printf(f, am.Mon.to_s + "\t" + am.Tue.to_s + "\t" + am.Wed.to_s + "\t" + am.Thu.to_s + "\t" + am.Fri.to_s + "\n")
       end
       printf(f, "\n")
       end
      printf(f, "\n")

# Maximale Anzahl an Operationssälen die an Tag k für Fachgebiet j genutzt werden kann

      printf(f, "table \n")
      printf(f, "c(j,k) \n\n")
      printf(f, "\t\t")
      days.each { |d| printf(f,  d.to_s + "\t") }
      printf(f, "\n")
      @specialty = Specialty.all
      @specialty.each do |op|
      printf(f, op.name.to_s + "\t")
      @room_specialty = RoomSpecialty.where(specialty_id: op.id)
      amount = 0
      @room_specialty.each do |rp|
        amount = amount + rp.operating_room.amount
      end
      days.each do
        printf(f, amount.to_s + "       ")
      end
      printf(f, "\n")
      end
      printf(f, "\n\n")

      #Bestrafungsfaktoren für die Verschiebung
      printf(f, "table \n")
      printf(f, "rho(k,l) \n\n")
      printf(f, "              ")
      days.each { |d| printf(f,  d.to_s + "        ") }
      printf(f, "\n")
      printf(f,
" Mon          7          1          2          3          4
 Tue          6          7          1          2          3
 Wed          5          6          7          1          2
 Thu          4          5          6          7          1
 Fri          3          4          5          6          7\n\n")

      printf(f, "table \n")
      printf(f, "lambda(k,l) \n\n")
      printf(f, "              ")
      days.each { |d| printf(f,  d.to_s + "        ") }
      printf(f, "\n")
      printf(f,
" Mon          7          1          2          3          4
 Tue          6          7          1          2          3
 Wed          5          6          7          1          2
 Thu          4          5          6          7          1
 Fri          3          4          5          6          7\n\n")


      f.close
      if File.exist?("Operationssaalzuordnung.txt")
        File.delete("Operationssaalzuordnung.txt")
      end
      system "C:\\GAMS\\win32\\24.3\\gams Operationssaalplanung"
 #     system "C:\\GAMS\\win64\\24.1\\gams Seminararbeit"
      flash.now[:started] = "Der Operationsplan wurde angelegt!"
      render 'static_pages/operationsplan_start'
    end


    private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Bitte melden Sie sich an."
      end
    end
#muss das letzte End nicht an eine andere Stelle?
  end
