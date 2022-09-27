class CreateReservation

  def call
    return false unless seats_selected?
      ActiveRecord::Base.transaction do
      reservation.save!
      create_tickets
    rescue StandardError
    end
  end
 
    private

    attr_reader :reservation, :params
    
    def initialize(reservation, params)
      @reservation = reservation
      @params = params
    end

    def create_tickets
        params[:seats].each do |seat|
          reservation.tickets.create(seat:)
        end
    end

    def seats_selected?
        !params[:seats].nil?
    end
 
end