# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  describe "associations" do
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to have_many(:promotions).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
