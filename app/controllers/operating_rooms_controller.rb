class OperatingRoomsController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user, only: :index
  before_filter :admin_user, except: :index
  # GET /operating_rooms
  # GET /operating_rooms.json
  def index
    @operating_rooms = OperatingRoom.all
    @room_specialty = RoomSpecialty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @operating_rooms }
    end
  end

  # GET /operating_rooms/1
  # GET /operating_rooms/1.json
  def show
    @operating_room = OperatingRoom.find(params[:id])
    @operating_rooms = @operating_room.id
    @room_specialty = RoomSpecialty.where(operating_room_id: @operating_rooms).to_a.map{|x| Specialty.find(x[:specialty_id]).name}


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @operating_room }
    end
  end

  # GET /operating_rooms/new
  # GET /operating_rooms/new.json
  def new
    @operating_room = OperatingRoom.new
 #   @room_specialty = RoomSpecialty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @operating_room }
    end
  end

  # GET /operating_rooms/1/edit
  def edit
    @operating_room = OperatingRoom.find(params[:id])
 #   @room_specialty = RoomSpecialty.find(params[:id])
  end

  # POST /operating_rooms
  # POST /operating_rooms.json
  def create
    @operating_room = OperatingRoom.new(params[:operating_room])
   # @room_specialty = RoomSpecialty.new(params[:room_specialty])

    respond_to do |format|
      if @operating_room.save
        format.html { redirect_to @operating_room, notice: 'Operating Room saved!' }
        format.json { render json: @operating_room, status: :created, location: @operating_room }
      else
        format.html { render action: "new" }
        format.json { render json: @operating_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /operating_rooms/1
  # PUT /operating_rooms/1.json
  def update
    @operating_room = OperatingRoom.find(params[:id])

    respond_to do |format|
      if @operating_room.update_attributes(params[:operating_room])
        format.html { redirect_to @operating_room, notice: 'Operating Room updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @operating_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operating_rooms/1
  # DELETE /operating_rooms/1.json
  def destroy
    @operating_room = OperatingRoom.find(params[:id])
    @operating_room.destroy

    respond_to do |format|
      format.html { redirect_to operating_rooms_url }
      format.json { head :no_content }
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