# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:reservation) }
  end

  describe "validations" do
    it { should validate_presence_of :seat }
  end
end
