# frozen_string_literal: true

module Screenings
  class Update
    def initialize(screening_id, params)
      @screening_id = screening_id
      @params = params
    end

    def call
      screening = Screening.find(screening_id)
      screening.update(params)
      screening
    end

    private

    attr_reader :screening_id, :params
  end
end
