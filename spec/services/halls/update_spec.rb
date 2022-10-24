# frozen_string_literal: true

require "rails_helper"

RSpec.describe Halls::Update do
  let!(:hall) { create :hall, name: "name", capacity: 40 }
  let(:params) do
    {
      name:,
      capacity: 41,
    }
  end
  let(:name) { Faker::Name.name }

  subject { described_class.new(hall.id, params).call }

  describe ".call" do
    it "updates hall" do
      expect { subject }
        .to change { hall.reload.name }.from("name").to(name)
        .and change { hall.reload.capacity }.from(40).to(41)
    end

    it { is_expected.to eq(hall) }

    it "returns hall object without errors" do
      expect(subject.errors).to be_empty
    end

    context "when params invalid" do
      let(:name) { nil }

      it "doesn't update hall" do
        expect { subject }.not_to change { hall.reload.name }
      end

      it { is_expected.to eq hall }

      it "returns hall object with errors array not empty" do
        expect(subject.errors).not_to be_empty
      end

      it "returns hall object with proper errors" do
        expect(subject.errors).to match_array(["Name can't be blank"])
      end
    end
  end
end
