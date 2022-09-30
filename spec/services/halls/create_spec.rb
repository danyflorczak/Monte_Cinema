# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Halls::Create do
  let(:params) do
    {
      name: 'name',
      capacity: 100
    }
  end
  subject { described_class.new(params).call }

  describe '.call' do
    it 'creates hall' do
      expect { subject }.to change { Hall.count }.by(1)
    end
  end
end
