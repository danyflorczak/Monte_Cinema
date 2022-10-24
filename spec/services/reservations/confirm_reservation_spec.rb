# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::ConfirmReservation do
  describe "#call" do
    context "when reservation is booked" do
      let!(:reservation) { create :reservation }
      subject { described_class.new(reservation).call }

      it "updates status to confirmed" do
        expect { subject }.to(change { reservation.status }.from("booked").to("confirmed"))
      end
    end

    context "when reservation status is confirmed" do
      let!(:reservation) { create :reservation, status: :confirmed }
      subject { described_class.new(reservation).call }

      it "does not update status" do
        expect { subject }.to_not(change { reservation.status })
      end
    end

    context "when reservation status is canceled" do
      let!(:reservation) { create :reservation, status: :canceled }
      subject { described_class.new(reservation).call }

      it "does not update status" do
        expect { subject }.to_not(change { reservation.status })
      end
    end
  end
end
