# frozen_string_literal: true

require "rails_helper"

RSpec.describe Hall do
  before do
    create(:hall)
  end

  describe "associations" do
    it { is_expected.to have_many(:screenings) }
    it { is_expected.to have_many(:movies).through(:screenings) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :capacity }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_numericality_of(:capacity).is_greater_than(0) }
  end
end
