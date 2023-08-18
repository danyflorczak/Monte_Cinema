# frozen_string_literal: true

require "rails_helper"

RSpec.describe Screening, type: :model do
  before do
    create(:screening)
  end

  describe "associations" do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:hall) }
    it { is_expected.to have_many(:reservations).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it "validates that end_time is greater than start_time" do
      screening = build(:screening, start_time: Time.zone.parse("2023-08-18 15:00:00"),
        end_time: Time.zone.parse("2023-08-18 16:49:00"),)
      expect(screening).to be_valid
    end

    it "validates used? method" do
      hall = create(:hall)
      existing_screening = create(:screening, hall:,
        start_time: Time.zone.parse("2023-08-18 21:00:00"),
        end_time: Time.zone.parse("2023-08-18 23:00:00"),)

      new_screening = build(:screening, hall:,
        start_time: Time.zone.parse("2023-08-18 22:00:00"),
        end_time: Time.zone.parse("2023-08-18 24:00:00"),)
      expect(new_screening).to_not be_valid
    end
  end

  describe "create screening" do
    it "sets the correct end_time using set_end_time method" do
      movie = create(:movie, duration: 120)
      hall = create(:hall)
      start_time = Time.zone.parse("2023-08-18 15:00:00")

      screening = create(:screening, movie:, hall:, start_time:)

      expect(screening.end_time).to eq(start_time + movie.duration.minutes + ADS_TIME)
    end
  end
end
