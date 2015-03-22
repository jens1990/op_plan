class AssignmentsController < ApplicationController
    before_filter :signed_in_user, only: [:show, :chart]
    before_filter :admin_user, except: [:index, :chart]

    # GET /assignments
    # GET /assignments.json
    def index
      if !Assignment.all.empty?
      @assignments = Assignment.where(calculation_id: Assignment.last.calculation_id)
      else
       @assignments = Assignment.all 
      end
      @assignmentsall = Assignment.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @assignments }
      end
    end
    
        def chart
    @assignmentc = Assignment.where(calculation_id: params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @assignment }
      end
    end

    # GET /assignments/1
    # GET /assignments/1.json
    def show
    @assignment = Assignment.find_by_calculation_id(params[:id])

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
      @assignment = Assignment.where(calculation_id: params[:id])
      @assignment.destroy(params[:id])

      respond_to do |format|
        format.html { redirect_to assignments_url }
        format.json { head :no_content }
      end
      redirect_to calculations_path
      flash[:not_available] = "Assignments deleted"
    end

    def gamspfadassignment
      $gamspath = params[:gamspath]
      redirect_to calculations_path
    end

    def destroyid
      @assignment = Assignment.where(calculation_id: params[:id])
      @assignment.destroy_all
      @stats = Stat.where(calculation_id: params[:id])
      @stats.destroy_all

      respond_to do |format|
        format.html { redirect_to calculations_path }
        format.json { head :no_content }
       end
      flash[:not_available] = "Assignments deleted"
      end

    def gamspfadassignment
      $gamspath = params[:gamspath]
      redirect_to calculations_path
    end

      def erase_assignments
      if File.exist?("Saalzuordnung.txt")
      File.delete("Saalzuordnung.txt")
      end
     Assignment.delete_all

        redirect_to assignments_path
     end





    def optimize

      calcid = Calculation.find(params[:id]).id
        # Ueberpruefung ob schon aggregiert wurde:
        if !Demand0.where(calculation_id: calcid).empty?
          # Ueberpruefung ob es eine neue Specialty seit dem letzten Aggregieren gibt
          if !Demand1.where(calculation_id: calcid).where(specialty_id: Specialty.last.id).empty?
      
      # Specialty Demand
      @demand1 = Demand1.where(calculation_id: calcid)
 
      # Fuer jede Specialty wird ueberprueft, ob etwas nicht gleich null ist an allen 5 Tagen. Patienten mit dem Typ 1
      empt = 1
      @demand1.each do |a|
          if a.Mon.nonzero? or a.Tue.nonzero? or a.Wed.nonzero? or a.Thu.nonzero? or a.Fri.nonzero?
          else
            # Selbe Pruefung nur fuer Patienten Typ 2  
            @spect = Demand2.where(calculation_id: calcid).where(specialty_id: a.specialty_id)

            if @spect.first.Mon.nonzero? or @spect.first.Tue.nonzero? or @spect.first.Wed.nonzero? or @spect.first.Thu.nonzero? or @spect.first.Fri.nonzero?
            else
              empt = 0
            end
          end
      end
      if empt == 0
        redirect_to calculations_path
        flash[:not_available] = "No demands for inpatients and outpatients in at least one specialty!"
      else       
      
      # Hier geht nun die Optimierung los, da alle Bedingungen erfuellt wurden
     
     #Delete aller alten Dateien
      if File.exist?("Operationsplan_Input.inc")
        File.delete("Operationsplan_Input.inc")
      end

      if File.exist?("Success.txt")
        File.delete("Success.txt")
      end

      if File.exist?("Saalzuordnung.txt")
       File.delete("Saalzuordnung.txt")
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
      # Hier nicht mehr alle Specialties
      @specialties = Specialty.all
      @specialties.each { |sp| printf(f, sp.shortcode.to_s + "\n") }
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
        printf(f,opsp.specialty.shortcode.to_s)
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
      printf(f, "s /" + workh + "/\n\n")

#Operationsnachfragen an den Tagen

#Notfall
     calcID = Calculation.find(params[:id]).id
     printf(f, "table \n")
     printf(f, "e(j,k) \n")
     printf(f, "\t\t")
     days.each { |d| printf(f,d.to_s + "\t\t") }
     printf(f, "\n")
     @demand0 = Demand0.where(:calculation_id => calcID)
     @demand0.each do |em|
      @specialty = Specialty.where(id: em.specialty_id)
        @specialty.each do |sp|
          printf(f, sp.shortcode.to_s + "\t\t")
          printf(f, em.Mon.to_s + "\t\t" + em.Tue.to_s + "\t\t" + em.Wed.to_s + "\t\t" + em.Thu.to_s + "\t\t" + em.Fri.to_s)
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
      @demand1 = Demand1.where(:calculation_id => calcID)
      @demand1.each do |st|
        @specialty = Specialty.where(id: st.specialty_id)
        @specialty.each do |sp|
          printf(f, sp.shortcode.to_s + "\t\t")
          printf(f, st.Mon.to_s + "\t\t" + st.Tue.to_s + "\t\t" + st.Wed.to_s + "\t\t" + st.Thu.to_s + "\t\t" + st.Fri.to_s)
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
      @demand2 = Demand2.where(:calculation_id => calcID)
      @demand2.each do |am|
        @specialty = Specialty.where(id: am.specialty_id)
        @specialty.each do |sp|
          printf(f, sp.shortcode.to_s + "\t\t")
          printf(f, am.Mon.to_s + "\t\t" + am.Tue.to_s + "\t\t" + am.Wed.to_s + "\t\t" + am.Thu.to_s + "\t\t" + am.Fri.to_s)
       end
       printf(f, "\n")
       end
      printf(f, "\n")

# Maximale Anzahl an Operationssälen die an Tag k für Fachgebiet j genutzt werden kann

      printf(f, "table \n")
      printf(f, "c(j,k) \n\n")
      printf(f, "\t\t")
      days.each { |d| printf(f,  d.to_s + "\t\t") }
      printf(f, "\n")

      @specialty = Specialty.all
      @specialty.each do |op|
      printf(f, op.shortcode.to_s + "\t\t")
      @room_specialty = RoomSpecialty.where(specialty_id: op.id)
      amount = 0
      @room_specialty.each do |rp|
        amount = amount + rp.operating_room.amount
      end
      days.each do
        printf(f, amount.to_s + "\t\t")
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


      #Kalkulationsnummer
      cal = Calculation.find(params[:id]).id.to_s
      printf(f, "scalar \n")
      printf(f, "cal /" + cal + "/\n\n")

      f.close

# Hier wird der Pfad aus der Variable gezogen

        if $gamspath.nil?
        system "C:\\GAMS\\win64\\24.1\\gams Operationssaalplanung"
        else
        system $gamspath
        end
 # While Schleife fuer das Warten bis ein Ergebnis vorliegt
     while !File.exists?("Success.txt") do
     sleep(1)
     end

      if File.exist?("Saalzuordnung.txt")

      #jede Specialty durchlaufen
          @specialties = Specialty.all
          @specialties.each do |spec|   
           
           # jede Specialty Room Kostellation
          @roomSpecialty = RoomSpecialty.where(specialty_id: spec.id) 
          @roomSpecialty.each do |rs|
           
          #jede Zeile durchlaufen  
          fi=File.open("Saalzuordnung.txt", "r")
          fi.each do |line|

          sa=line.split(";")
          sa0 =sa[0]
          sa1 =sa[1]
          sa2 =sa[2]
          sa3 =sa[3]
          sa4 =sa[4].delete " \n"

        speccode = Specialty.where(shortcode: sa3).first.id
        opr = OperatingRoom.where(name: sa2).first.id
        
        #Ueberpruefen ob in Zeile die gerade gesuchte Specialty steht               
        if speccode == spec.id and opr == rs.operating_room_id
           
           if sa1 == 'Mon'
            @sa4Mon = sa4
           end

           if sa1 == 'Tue'
           @sa4Tue = sa4
           end

           if sa1 == 'Wed'
           @sa4Wed = sa4
           end

           if sa1 == 'Thu'
           @sa4Thu = sa4
           end

           if sa1 == 'Fri'
           @sa4Fri = sa4
           Assignment.create!(calculation_id: sa0,
                           specialty_id: speccode,
                           operating_room_id: opr,
                           Mon: @sa4Mon,
                           Tue: @sa4Tue,
                           Wed: @sa4Wed,
                           Thu: @sa4Thu,
                           Fri: @sa4Fri)
           end
         end  
       end
        fi.close
      end  
     end

        #Statistiken einlesen
         fi=File.open("Saalzuordnung_Statistik.txt", "r")
        fi.each do |line|
        # printf(f,line)

          sa=line.split(";")
          sa0 =sa[0]
          sa1 =sa[1]
          sa2 =sa[2]
          sa3 =sa[3]
          sa4 =sa[4]
          sa5 =sa[5].delete " \n"

        Stat.create!(calculation_id: sa0,
                           specialty_id: Specialty.where(shortcode: sa1).first.id,
                           day: sa2,
                           not_sat_out: sa3,
                           not_sat_in: sa4,
                           idle_time: sa5
                           )
        end
        fi.close
        redirect_to assignments_path
        flash[:started] = "Assignment calculated!"
       else
       flash[:not_available] = "No assignment could be calculated! Possible errors: No solution exists. Please check on the data."
       @assignments = Assignment.all
        redirect_to calculations_path
      end
    end
      else
        redirect_to calculations_path
        flash[:started] = "There is a new Specialty! Please aggregate first with this new Specialty!"
      end
      else
        redirect_to calculations_path
        flash[:started] = "Please aggregate first!"
      end
     
 end



#Testfunktion für den Gams Pfad
   def test
     if File.exist?("test.txt")
        File.delete("test.txt")
     end
   testv=0
   # Wenn der Gamspfad null ist, wird der Standardpfad eingetragen
   if $gamspath.nil?
        $gamspath = "C:\\GAMS\\win64\\24.1\\gams Operationssaalplanung"
        else
        end
    if $gamspath.include? "Operationssaalplanung"
      # Operationsplanung wird durch Testpfad ersetzt
      system $gamspath.sub! 'Operationssaalplanung', 'Testpfad'  
      # 2 Sekunden warten
      sleep(2)
      # Wenn txt existiert wird Variable auf 1 gesetzt
        if File.exist?("test.txt")
          testv=1
          $gamspath.sub! 'Testpfad', 'Operationssaalplanung'
        end
        redirect_to calculations_path
           if testv==1
            flash[:started] = "Gams path correct!"
           else
           flash[:not_available] = "Gams path is not correct! Please see the help site for further information."
           end
        else
        redirect_to calculations_path
        flash[:not_available] = "The last part should contain <Operationssaalplanung>"
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
