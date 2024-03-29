# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation do
  describe "associations" do
    it { is_expected.to belong_to(:screening) }
    it { is_expected.to belong_to(:user).optional(true) }
    it { is_expected.to have_one(:hall).through(:screening) }
    it { is_expected.to have_one(:movie).optional(:screening) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :email }
  end
end
