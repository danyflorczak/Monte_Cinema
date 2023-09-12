# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/promotions" do
  let(:user) { create(:user) }

  describe "GET /promotions" do
    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/promotions")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/promotions")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in user }

      it "returns successful response" do
        get("/promotions")
        expect(response).to have_http_status(:ok)
      end

      it "renders proper template" do
        get("/promotions")
        expect(response).to render_template("promotions/index")
      end
    end
  end
end
