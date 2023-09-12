# frozen_string_literal: true

require "rails_helper"

RSpec.describe Role do
  describe "associations" do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:actor) }
  end
end
