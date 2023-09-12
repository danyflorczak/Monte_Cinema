# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/halls" do
  let(:user) { create(:user) }
  let(:manager) { create(:user, email: "admin@gmail.com", role: :manager) }

  describe "GET /reservations" do
    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/reservations")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/reservations")
        expect(response).to have_http_status(:found)
      end
    end
  end

  context "when user with permission" do
    before { sign_in manager }

    it "returns successful response" do
      get("/reservations")
      expect(response).to have_http_status(:ok)
    end

    it "renders proper template" do
      get("/reservations")
      expect(response).to render_template("reservations/index")
    end
  end

  describe "GET screenings/screening_id/reservations/new" do
    let(:screening) { create(:screening) }

    it "returns successful response" do
      get("/screenings/#{screening.id}/reservations/new")
      expect(response).to have_http_status(:ok)
    end

    it "renders proper template" do
      get("/screenings/#{screening.id}/reservations/new")
      expect(response).to render_template("reservations/new")
    end
  end
end
