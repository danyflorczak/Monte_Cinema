# frozen_string_literal: true

module Screenings
  class Create
    def initialize(params)
      @params = params
    end

    def call
      screening = Screening.create(params)
      screening.set_end_time
      screening.save
      screening
    end

    private

    attr_reader :params
  end
end
