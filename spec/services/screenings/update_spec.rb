# frozen_string_literal: true

require "rails_helper"

RSpec.describe Screenings::Update do
  let!(:screening) { create :screening }
  let(:params) do
    {
      movie_id: screening.movie.id,
      hall_id: screening.hall.id,
      start_time: DateTime.current.beginning_of_minute,
      price:,
    }
  end
  let(:price) { rand(15..24) }

  subject { described_class.new(screening.id, params).call }

  describe ".call" do
    it "updates screening" do
      expect { subject }
        .to change { screening.reload.price }.from(screening.price).to(price)
    end

    it { is_expected.to eq(screening) }

    it "returns screening object without errors" do
      expect(subject.errors).to be_empty
    end

    context "when params invalid" do
      let(:price) { nil }

      it "doesn't update screening" do
        expect { subject }.not_to change { screening.reload.price }
      end

      it { is_expected.to eq screening }

      it "returns screening object with errors array not empty" do
        expect(subject.errors).not_to be_empty
      end
    end
  end
end
