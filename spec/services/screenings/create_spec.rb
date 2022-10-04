# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Screenings::Create do
  let(:movie) { create :movie }
  let(:hall) { create :hall }
  let(:params) do
    {
      movie_id: movie.id,
      hall_id: hall.id,
      start_time: DateTime.current.beginning_of_minute,
      price: 20
    }
  end
  subject { described_class.new(params).call }

  describe '.call' do
    it 'creates screening' do
      expect { subject }.to change { Screening.count }.by(1)
    end
  end
end
