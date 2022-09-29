module Halls
  class Delete
    def initialize(hall_id)
      @hall_id = hall_id
    end

    def call
      hall = Hall.find(hall_id)
      hall.destroy
    end

    private

    attr_reader :hall_id
  end
end