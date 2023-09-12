# frozen_string_literal: true

require "rails_helper"

RSpec.describe Halls::Create do
  subject(:create_hall) { described_class.new(params).call }

  let(:params) do
    {
      name: Faker::FunnyName.name,
      capacity: Faker::Number.number(digits: 2)
    }
  end

  describe ".call" do
    it "creates the hall" do
      expect { create_hall }.to change(Hall, :count).by(1)
    end
  end
end
