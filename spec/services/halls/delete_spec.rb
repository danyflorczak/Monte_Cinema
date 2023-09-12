# frozen_string_literal: true

require "rails_helper"

RSpec.describe Halls::Delete do
  subject(:delete_hall) { instance.call }

  let!(:hall) { create(:hall) }
  let(:instance) { described_class.new(hall.id) }

  describe ".call" do
    it "deletes the hall" do
      expect { delete_hall }.to change(Hall, :count).by(-1)
    end
  end
end
