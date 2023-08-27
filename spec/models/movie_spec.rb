# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movie, type: :model do
  before do
    create(:movie)
  end

  describe "associations" do
    it { is_expected.to have_many(:screenings) }
    it { is_expected.to have_many(:halls).through(:screenings) }
    it { is_expected.to have_and_belong_to_many(:actors) }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :director }
    it { should validate_presence_of :release_date }
    it { should validate_presence_of :genre }
    it { should validate_uniqueness_of :title }
    it { should validate_numericality_of(:duration).is_greater_than(0) }
  end
end
