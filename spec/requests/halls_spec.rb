# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/halls" do
  let(:user) { create(:user) }
  let(:manager) { create(:user, email: "admin@gmail.com", role: :manager) }

  describe "GET /halls" do
    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/halls")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/halls")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        get("/halls")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        get("/halls")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns successful response" do
        get("/halls")
        expect(response).to have_http_status(:ok)
      end

      it "renders proper template" do
        get("/halls")
        expect(response).to render_template("halls/index")
      end
    end
  end

  describe "GET /halls/new" do
    context "when no user" do
      it "redirects to sign_in" do
        get("/halls/new")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/halls/new")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        get("/halls/new")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        get("/halls/new")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns successful response" do
        get("/halls/new")
        expect(response).to have_http_status(:ok)
      end

      it "renders proper template" do
        get("/halls/new")
        expect(response).to render_template("halls/new")
      end
    end
  end

  describe "POST /halls" do
    let(:params) { { hall: attributes_for(:hall, name:, capacity:) } }
    let(:name) { Faker::FunnyName.name }
    let(:capacity) { Faker::Number.number(digits: 2).to_i }

    context "when no user" do
      it "redirects to sign_in" do
        post("/halls")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        post("/halls")
        expect(response).to have_http_status(:found)
      end

      it "does not create a hall" do
        expect { post("/halls", params:) }.not_to change(Hall, :count)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        post("/halls", params:)
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        post("/halls")
        expect(response).to have_http_status(:found)
      end

      it "does not create a hall" do
        expect { post("/halls", params:) }.not_to change(Hall, :count)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns redirect status" do
        post("/halls", params:)
        expect(response).to have_http_status(:found)
      end

      it "creates hall" do
        expect { post("/halls", params:) }.to change(Hall, :count).by(1)
      end
    end

    context "when params invalid" do
      before { sign_in manager }

      let(:name) { nil }
      let(:capacity) { "s" }

      it "doesn't create hall" do
        expect { post("/halls", params:) }.not_to change(Hall, :count)
      end

      it "returns unsuccessful response" do
        post("/halls", params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /halls/:hall_id/edit" do
    let(:hall) { create(:hall) }

    context "when user not signed in" do
      it "redirects to sign_in" do
        get("/halls/#{hall.id}/edit")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        get("/halls/#{hall.id}/edit")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        get("/halls/#{hall.id}/edit")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        get("/halls/#{hall.id}/edit")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns successful response" do
        get("/halls/#{hall.id}/edit")
        expect(response).to have_http_status(:ok)
      end

      it "renders proper template" do
        get("/halls/#{hall.id}/edit")
        expect(response).to render_template("halls/edit")
      end
    end
  end

  describe "PATCH /halls/:hall_id" do
    let(:hall) { create(:hall) }
    let(:params) { { hall: attributes_for(:hall, name:, capacity:) } }
    let(:name) { "Hall #{Faker::Number.number(digits: 1)}" }
    let(:capacity) { Faker::Number.number(digits: 2).to_i }

    context "when user not signed in" do
      it "redirects to sign_in" do
        patch("/halls/#{hall.id}", params:)
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        patch("/halls/#{hall.id}")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        patch("/halls/#{hall.id}", params:)
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        patch("/halls/#{hall.id}")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns redirect status" do
        patch("/halls/#{hall.id}", params:)
        expect(response).to have_http_status(:found)
      end

      it "updates hall" do
        expect { patch("/halls/#{hall.id}", params:) }.to change {
                                                            hall.reload.name
                                                          }.from(hall.name).to(name.to_s)
      end
    end

    context "when params invalid" do
      before { sign_in manager }

      let(:name) { nil }
      let(:capacity) { "s" }

      it "doesn't update hall" do
        expect { patch("/halls/#{hall.id}", params:) }.not_to(change { hall.reload.name })
      end

      it "returns unsuccessful response" do
        patch("/halls/#{hall.id}", params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /halls/:hall_id" do
    let!(:hall) { create(:hall) }

    context "when user not signed in" do
      it "redirects to sign_in" do
        delete("/halls/#{hall.id}")
        expect(response).to redirect_to("/users/sign_in")
      end

      it "returns redirect status" do
        delete("/halls/#{hall.id}")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user without permission" do
      before { sign_in user }

      it "redirects to root" do
        delete("/halls/#{hall.id}")
        expect(response).to redirect_to("/")
      end

      it "returns redirect status" do
        delete("/halls/#{hall.id}")
        expect(response).to have_http_status(:found)
      end
    end

    context "when user with permission" do
      before { sign_in manager }

      it "returns redirect status" do
        delete("/halls/#{hall.id}")
        expect(response).to have_http_status(:found)
      end

      it "redirects to /halls" do
        delete("/halls/#{hall.id}")
        expect(response).to redirect_to("/halls")
      end

      it "destroys the hall record" do
        expect { delete("/halls/#{hall.id}") }.to change(Hall, :count).by(-1)
      end
    end
  end
end
