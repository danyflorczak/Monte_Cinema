class ScreeningsController < ApplicationController
    before_action :set_screening, only: %i[ show edit update destroy ]
  
    # GET /screenings 
    def index
      @screenings = Screening.all
    end
  
    # GET /screenings/id
    def show
    end
  
    # GET /screenings/new
    def new
      @screening = Screening.new
    end
  
    # GET /screenings/id/edit
    def edit
    end
  
    # POST /screenings 
    def create
      @screening = Screening.new(screening_params)
        if @screening.save
            redirect_to screening_url(@screening), notice: "Screening was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
    end
  
    # PATCH/PUT /screenings/id
    def update
        if @screening.update(screening_params)
            redirect_to screening_url(@screening), notice: "Screening was successfully updated." 
        else
          render :edit, status: :unprocessable_entity
        end
    end
  
    # DELETE /screenings/id
    def destroy
      @screening.destroy
      redirect_to screenings_url, notice: "Screening was successfully destroyed."
    end
  
    private
      def set_screening
        @screening = Screening.find(params[:id])
      end

      def screening_params
        params.require(:screening).permit(:movie_id, :hall_id,:start_time, :end_time, :price)
      end
  end
  