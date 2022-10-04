# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Screenings::Delete do
  let!(:screening) { create :screening }
  let(:instance) { described_class.new(screening.id) }

  subject { instance.call }

  describe '.call' do
    it 'deletes screening' do
      expect { subject }.to change { Screening.count }.by(-1)
    end
  end
end
