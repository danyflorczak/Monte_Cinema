module Halls
  class Create
    def initialize(params)
      @params = params
    end

    def call
      Hall.create(params)
    end

    private

    attr_reader :params
  end
end