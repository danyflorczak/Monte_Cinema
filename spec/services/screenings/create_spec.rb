# frozen_string_literal: true

require "rails_helper"

RSpec.describe Screenings::Create do
  subject(:create_screening) { described_class.new(params).call }

  let(:movie) { create(:movie) }
  let(:hall) { create(:hall) }
  let(:params) do
    {
      movie_id: movie.id,
      hall_id: hall.id,
      start_time: DateTime.current.beginning_of_minute,
      price: 20
    }
  end

  describe ".call" do
    it "creates the screening" do
      expect { create_screening }.to change(Screening, :count).by(1)
    end
  end
end
