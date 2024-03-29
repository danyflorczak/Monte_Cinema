# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/halls" do
  let(:user) { create(:user) }
  let(:manager) { create(:user, email: "admin@gmail.com", role: :manager) }

  describe "GET /screenings" do
    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/screenings")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/screenings")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        get("/screenings")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        get("/screenings")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns successful response" do
        get("/screenings")
        expect(response).to have_http_status(:ok)
      end

      it "renders proper template" do
        get("/screenings")
        expect(response).to render_template("screenings/index")
      end
    end
  end

  describe "GET /screenings/new" do
    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/screenings/new")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/screenings/new")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        get("/screenings/new")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        get("/screenings/new")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns successful response" do
        get("/screenings/new")
        expect(response).to have_http_status(:ok)
      end

      it "renders proper template" do
        get("/screenings/new")
        expect(response).to render_template("screenings/new")
      end
    end
  end

  describe "GET /screenings/:screening_id" do
    subject(:request) { get("/screenings/#{screening.id}") }

    let(:screening) { create(:screening) }

    it "returns successful response" do
      request
      expect(response).to have_http_status(:ok)
    end

    it "renders proper template" do
      request
      expect(response).to render_template("screenings/show")
    end
  end

  describe "POST /screenings" do
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:params) do
      { screening: attributes_for(:screening, movie_id: movie.id, hall_id: hall.id,
                                              start_time: DateTime.current.beginning_of_minute, price: rand(15..24)) }
    end

    context "when user not signed in" do
      it "redirects to sign_in" do
        post("/screenings")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        post("/screenings")
        expect(response).to have_http_status(:found)
      end

      it "does not create a screening" do
        expect { post("/screenings", params:) }.not_to change(Screening, :count)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        post("/screenings", params:)
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        post("/screenings")
        expect(response).to have_http_status(:found)
      end

      it "does not create a screening" do
        expect { post("/screenings", params:) }.not_to change(Screening, :count)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns redirect status" do
        post("/screenings", params:)
        expect(response).to have_http_status(:found)
      end

      it "redirects to screenings/screening_id" do
        post("/screenings", params:)
        expect(response).to redirect_to(action: :show, id: assigns(:screening).id)
      end

      it "creates screening" do
        expect { post("/screenings", params:) }.to change(Screening, :count).by(1)
      end
    end
  end

  describe "DELETE /screenings/:id" do
    let!(:screening) { create(:screening) }

    context "when no user" do
      it "redirects to sign_in" do
        delete("/screenings/#{screening.id}")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        delete("/screenings/#{screening.id}")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        delete("/screenings/#{screening.id}")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        delete("/screenings/#{screening.id}")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns redirect status" do
        delete("/screenings/#{screening.id}")
        expect(response).to have_http_status(:found)
      end

      it "redirects to /screenings" do
        delete("/screenings/#{screening.id}")
        expect(response).to redirect_to("/screenings")
      end

      it "destroys screening" do
        expect { delete("/screenings/#{screening.id}") }.to change(Screening, :count).by(-1)
      end
    end
  end
end
