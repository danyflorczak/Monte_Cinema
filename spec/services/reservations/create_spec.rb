# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::Create do
  subject(:create_reservation) { described_class.new(**params) }

  let(:screening) { create(:screening) }
  let(:params) do
    {
      screening_id: screening.id,
      email: "test@gmail.com",
      status: :booked,
      seats: [rand(1..50).to_s]
    }
  end

  describe "#call" do
    it "creates a reservation" do
      expect { create_reservation.call }.to change(Reservation, :count).by(1)
    end

    it "creates tickets" do
      expect { create_reservation.call }.to(change(Ticket, :count))
    end
  end
end
