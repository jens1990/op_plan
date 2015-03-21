class RoomSpecialtiesController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user
  # GET /room_specialties
  # GET /room_specialties.json
  def index
     @room_specialty = RoomSpecialty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @room_specialties }
    end
  end

  # GET /room_specialties/1
  # GET /room_specialties/1.json
#  def show
#    @room_specialty = where(operating_room_id: (params[:id]))
#   @room_specialty = RoomSpecialty.where(room_specialty_id: @room_specialties).to_a.map{|x| x[:specialty_id]}


#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @room_specialty }
#    end
#  end

  # GET /room_specialties/new
  # GET /room_specialties/new.json
# def new
#    @room_specialty = RoomSpecialty.new

#    respond_to do |format|
#     format.html # new.html.erb
#     format.json { render json: @room_specialty }
#   end
# end

  # GET /room_specialties/1/edit
  def edit
    @room_specialty = RoomSpecialty.where(operating_room_id: (params[:id]))
    @oprid = params[:id]
  end

  # POST /room_specialties
  # POST /room_specialties.json
  def create
   @room_specialty = RoomSpecialty.new(params[:room_specialty])

    respond_to do |format|
     if @room_specialty.save
      format.html { redirect_to @room_specialty, notice: 'Operating Room saved!' }
       format.json { render json: @room_specialty, status: :created, location: @room_specialty }
      else
        format.html { render action: "new" }
        format.json { render json: @room_specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign
    @oprid = params[:id]
    spid = params[:spid]
    RoomSpecialty.create!(operating_room_id: @oprid,
                           specialty_id: spid,
                           )
    redirect_to :back
  end
  
    def unassign
      @oprid = params[:id]
      spid = params[:spid]
     delid = RoomSpecialty.where(operating_room_id: @oprid).where(specialty_id: spid).first.id
     @room_specialty = RoomSpecialty.find(delid)
     @room_specialty.destroy
     redirect_to :back
  end

 # def destroy
 #   @room_specialty = RoomSpecialty.where(operating_room_id: params[:id]).where(specialty_id: params[:spid])
 #   @room_specialty.destroy

#    respond_to do |format|
#      format.html { redirect_to room_specialties_url }
#      format.json { head :no_content }
#    end
# end



  # PUT /room_specialties/1
  # PUT /room_specialties/1.json
#  def update
#    @room_specialty = RoomSpecialty.where(operating_room_id: (params[:id]))

    #respond_to do |format|
    #  if @room_specialty.update_attributes(params[:room_specialty])
    #    format.html { redirect_to @room_specialty, notice: 'Operating Room updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @room_specialty.errors, status: :unprocessable_entity }
    #  end
    #end
  #end

  # DELETE /room_specialties/1
  # DELETE /room_specialties/1.json
#  def destroy
 #   @room_specialty = RoomSpecialty.where(operating_room_id: (params[:id]))
 #   @room_specialty.destroy

#    respond_to do |format|
 #     format.html { redirect_to room_specialties_url }
 #     format.json { head :no_content }
 #   end
 # end
end


private

def admin_user
  unless current_user.admin?
    store_location
    redirect_to signin_path, notice: "This area is only available as administrator!"
  end
end