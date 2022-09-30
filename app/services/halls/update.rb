# frozen_string_literal: true

module Halls
  class Update
    def initialize(hall_id, params)
      @hall_id = hall_id
      @params = params
    end

    def call
      hall = Hall.find(hall_id)
      hall.update(params)
      hall
    end

    private

    attr_reader :hall_id, :params
  end
end
