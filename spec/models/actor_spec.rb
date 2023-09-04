# frozen_string_literal: true

require "rails_helper"

RSpec.describe Actor, type: :model do
  describe "associations" do
    it { should have_many(:roles) }
    it { should have_many(:movies).through(:roles) }
  end
end
