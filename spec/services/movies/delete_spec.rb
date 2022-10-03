# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::Delete do
  let!(:movie) { create :movie }
  let(:instance) { described_class.new(movie.id) }

  subject { instance.call }

  describe '.call' do
    it 'deletes movie' do
      expect { subject }.to change { Movie.count }.by(-1)
    end
  end
end
