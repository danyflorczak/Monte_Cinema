module Halls
  class Update
    def initialize(hall_id, params)
      @hall_id = hall_id
      @params = params
    end

    def call
      hall = Hall.find(hall_id)

      if hall.screenings.any?
        hall.errors.add(:base, "You can't change properties of halls that are already in use")
        return hall
      end

      hall.update(params)
      hall
    end

    private

    attr_reader :hall_id, :params
  end
end
