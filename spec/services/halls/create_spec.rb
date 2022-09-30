# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Halls::Create do
  let(:params) do
    {
      name: 'name',
      capacity: 100
    }
  end
  let(:instance) { described_class.new(params) }

  describe '.call' do
    it 'creates hall' do
      expect { instance.call }.to change { Hall.count }.by(1)
    end
  end
end
