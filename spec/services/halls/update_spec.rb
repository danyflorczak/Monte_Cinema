# frozen_string_literal: true

require "rails_helper"

RSpec.describe Halls::Update do
  subject(:update_hall) { described_class.new(hall.id, params).call }

  let!(:hall) { create(:hall, name: "name", capacity: 40) }
  let(:params) do
    {
      name: Faker::Name.name,
      capacity: 41
    }
  end

  describe ".call" do
    it "updates the hall" do
      expect { update_hall }
        .to change { hall.reload.name }.from("name").to(params[:name])
        .and change { hall.reload.capacity }.from(40).to(params[:capacity])
    end

    it { is_expected.to eq(hall) }

    it "returns hall object without errors" do
      expect(update_hall.errors).to be_empty
    end

    context "when params are invalid" do
      let(:params) { { name: nil, capacity: 41 } }

      it "doesn't update the hall" do
        expect { update_hall }.not_to(change { hall.reload.name })
      end

      it { is_expected.to eq hall }

      it "returns hall object with errors array not empty" do
        expect(update_hall.errors).not_to be_empty
      end

      it "returns hall object with proper errors" do
        expect(update_hall.errors).to contain_exactly("Name can't be blank")
      end
    end
  end
end
