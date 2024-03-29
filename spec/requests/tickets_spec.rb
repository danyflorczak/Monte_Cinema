# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tickets" do
  let(:reservation) { create(:reservation) }

  describe "GET /index" do
    it "returns http success" do
      get reservation_tickets_url(reservation)
      expect(response).to have_http_status(:success)
    end
  end
end
