# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movies::Create do
  subject(:create_movie) { described_class.new(params).call }

  let(:params) do
    {
      title: Faker::Movie.title,
      description: Faker::Movie.quote,
      duration: Faker::Number.number(digits: 2).to_i,
      genre: Faker::Book.genre,
      director: Faker::Name.name,
      release_date: Faker::Date.between(from: 20.years.ago, to: Time.zone.today)
    }
  end

  describe ".call" do
    it "creates the movie" do
      expect { create_movie }.to change(Movie, :count).by(1)
    end
  end
end
