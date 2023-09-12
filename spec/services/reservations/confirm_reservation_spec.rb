# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::ConfirmReservation do
  describe "#call" do
    context "when reservation is booked" do
      subject(:confirm_reservation) { described_class.new(reservation).call }

      let!(:reservation) { create(:reservation) }

      it "updates status to confirmed" do
        expect { confirm_reservation }.to(change(reservation, :status).from("booked").to("confirmed"))
      end
    end

    context "when reservation status is confirmed" do
      subject(:confirm_reservation) { described_class.new(reservation).call }

      let!(:reservation) { create(:reservation, status: :confirmed) }

      it "does not update status" do
        expect { confirm_reservation }.not_to(change(reservation, :status))
      end
    end

    context "when reservation status is canceled" do
      subject(:confirm_reservation) { described_class.new(reservation).call }

      let!(:reservation) { create(:reservation, status: :canceled) }

      it "does not update status" do
        expect { confirm_reservation }.not_to(change(reservation, :status))
      end
    end
  end
end
