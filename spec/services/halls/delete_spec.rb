# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Halls::Delete do
  let!(:hall) { create :hall, name: 'name', capacity: 30 }
  let(:instance) { described_class.new(hall.id) }

  subject { instance.call }

  describe '.call' do
    it 'deletes hall' do
      expect { subject }.to change { Hall.count }.by(-1)
    end
  end
end
