# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/promotions", type: :request do
  let(:user) { create :user }
  describe "GET /promotions" do
    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/promotions")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/promotions")
        expect(response.status).to eq(302)
      end
    end

    context "when user with permission" do
      before { sign_in user }
      it "returns successful response" do
        get("/promotions")
        expect(response.status).to eq(200)
      end

      it "renders proper template" do
        get("/promotions")
        expect(response).to render_template("promotions/index")
      end
    end
  end
end
