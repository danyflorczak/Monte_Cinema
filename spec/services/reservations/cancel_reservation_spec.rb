# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::CancelReservation do
  describe "#call" do
    context "when reservation is booked" do
      subject(:cancel_reservation) { described_class.new(reservation).call }

      let!(:reservation) { create(:reservation) }

      it "updates status to canceled" do
        expect { cancel_reservation }.to(change(reservation, :status).from("booked").to("canceled"))
      end
    end

    context "when reservation status is confirmed" do
      subject(:cancel_reservation) { described_class.new(reservation).call }

      let!(:reservation) { create(:reservation, status: :confirmed) }

      it "does not update status" do
        expect { cancel_reservation }.not_to(change(reservation, :status))
      end
    end

    context "when reservation status is canceled" do
      subject(:cancel_reservation) { described_class.new(reservation).call }

      let!(:reservation) { create(:reservation, status: :canceled) }

      it "does not update status" do
        expect { cancel_reservation }.not_to(change(reservation, :status))
      end
    end
  end
end
