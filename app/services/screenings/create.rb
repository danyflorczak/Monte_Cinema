# frozen_string_literal: true

module Screenings
  class Create
    def initialize(params)
      @params = params
    end

    def call
      Screening.create(params)
    end

    private

    attr_reader :params
  end
end
