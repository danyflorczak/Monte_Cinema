# frozen_string_literal: true

require "rails_helper"

RSpec.describe Actor do
  describe "associations" do
    it { is_expected.to have_many(:roles) }
    it { is_expected.to have_many(:movies).through(:roles) }
  end
end
