# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movie do
  before do
    create(:movie)
  end

  describe "associations" do
    it { is_expected.to have_many(:screenings) }
    it { is_expected.to have_many(:halls).through(:screenings) }
    it { is_expected.to have_many(:roles) }
    it { is_expected.to have_many(:actors).through(:roles) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :duration }
    it { is_expected.to validate_presence_of :director }
    it { is_expected.to validate_presence_of :release_date }
    it { is_expected.to validate_presence_of :genre }
    it { is_expected.to validate_uniqueness_of :title }
    it { is_expected.to validate_numericality_of(:duration).is_greater_than(0) }
  end
end
