# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movies::Create do
  let(:params) do
    {
      title: Faker::Movie.title,
      description: Faker::Movie.quote,
      duration: Faker::Number.number(digits: 2).to_i,
      genre: Faker::Book.genre,
      director: Faker::Name.name,
      release_date: Faker::Date.between(from: 20.years.ago, to: Date.today),
    }
  end
  subject { described_class.new(params).call }

  describe ".call" do
    it "creates movie" do
      expect { subject }.to change { Movie.count }.by(1)
    end
  end
end
