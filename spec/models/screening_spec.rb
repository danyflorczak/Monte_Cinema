# frozen_string_literal: true

require "rails_helper"

RSpec.describe Screening do
  before do
    create(:screening)
  end

  describe "associations" do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:hall) }
    it { is_expected.to have_many(:reservations).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }

    it "validates used? method" do
      hall = create(:hall)
      create(:screening, hall:,
                         start_time: Time.zone.parse("2023-08-18 21:00:00"),
                         end_time: Time.zone.parse("2023-08-18 23:00:00"))

      new_screening = build(:screening, hall:,
                                        start_time: Time.zone.parse("2023-08-18 22:00:00"),
                                        end_time: Time.zone.parse("2023-08-18 24:00:00"))
      expect(new_screening).not_to be_valid
    end
  end
end
