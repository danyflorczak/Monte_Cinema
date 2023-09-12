# frozen_string_literal: true

require "rails_helper"

RSpec.describe Screenings::Delete do
  subject(:delete_screening) { instance.call }

  let!(:screening) { create(:screening) }
  let(:instance) { described_class.new(screening.id) }

  describe ".call" do
    it "deletes the screening" do
      expect { delete_screening }.to change(Screening, :count).by(-1)
    end
  end
end
