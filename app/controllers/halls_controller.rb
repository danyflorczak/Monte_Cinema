class HallsController < ApplicationController
    before_action :set_hall, only: %i[ show edit update destroy ]
  
    # GET /halls 
    def index
      @halls = Hall.all
    end
  
    # GET /halls/id
    def show
    end
  
    # GET /halls/new
    def new
      @hall = Hall.new
    end
  
    # GET /halls/id/edit
    def edit
    end
  
    # POST /halls 
    def create
      @hall = Hall.new(hall_params)
      if @hall.save
        redirect_to hall_url(@hall), notice: "Hall was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end
    end
  
    # PATCH/PUT /halls/id
    def update
      if @hall.update(hall_params)
        redirect_to hall_url(@hall), notice: "Hall was successfully updated." 
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /halls/id
    def destroy
      @hall.destroy
      redirect_to halls_url, notice: "Hall was successfully destroyed." 
    end
  
    private
      def set_hall
        @hall = Hall.find(params[:id])
      end

      def hall_params
        params.require(:hall).permit(:name, :capacity)
      end
  end
  