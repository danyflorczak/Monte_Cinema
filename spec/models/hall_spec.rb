# frozen_string_literal: true

require "rails_helper"

RSpec.describe Hall, type: :model do
  before do
    create(:hall)
  end

  describe "associations" do
    it { is_expected.to have_many(:screenings) }
    it { is_expected.to have_many(:movies).through(:screenings) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :capacity }
    it { should validate_uniqueness_of :name }
    it { should validate_numericality_of(:capacity).is_greater_than(0) }
  end
end
