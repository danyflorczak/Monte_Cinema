# frozen_string_literal: true

module Screenings
  class Delete
    def initialize(screening_id)
      @screening_id = screening_id
    end

    def call
      screening = Screening.find(screening_id)
      screening.destroy
    end

    private

    attr_reader :screening_id
  end
end
