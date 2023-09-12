# frozen_string_literal: true

require "rails_helper"

RSpec.describe Screenings::Update do
  let!(:screening) { create(:screening) }
  let(:params) do
    {
      movie_id: screening.movie.id,
      hall_id: screening.hall.id,
      start_time: DateTime.current.beginning_of_minute,
      price:
    }
  end
  let(:price) { rand(15..24) }

  describe ".call" do
    subject(:update_screening) { described_class.new(screening.id, params).call }

    it "updates screening" do
      expect { update_screening }
        .to change { screening.reload.price }.from(screening.price).to(price)
    end

    it "returns the updated screening object" do
      expect(update_screening).to eq(screening)
    end

    it "returns the screening object without errors" do
      expect(update_screening.errors).to be_empty
    end

    context "when params are invalid" do
      let(:price) { nil }

      it "doesn't update screening" do
        expect { update_screening }.not_to(change { screening.reload.price })
      end

      it "returns the screening object" do
        expect(update_screening).to eq(screening)
      end

      it "returns the screening object with errors array not empty" do
        expect(update_screening.errors).not_to be_empty
      end
    end
  end
end
