# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movies::Delete do
  subject(:delete_movie) { instance.call }

  let!(:movie) { create(:movie) }
  let(:instance) { described_class.new(movie.id) }

  describe ".call" do
    it "deletes the movie" do
      expect { delete_movie }.to change(Movie, :count).by(-1)
    end
  end
end
