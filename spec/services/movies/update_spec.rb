# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movies::Update do
  subject(:update_movie) { described_class.new(movie.id, params).call }

  let!(:movie) { create(:movie) }
  let(:params) do
    {
      title:,
      description: Faker::Movie.quote,
      duration: Faker::Number.number(digits: 2).to_i
    }
  end
  let(:title) { Faker::Movie.title }

  describe ".call" do
    it "updates the movie" do
      expect { update_movie }
        .to change { movie.reload.title }.from(movie.title).to(title)
        .and change { movie.reload.description }.from(movie.description).to(params[:description])
        .and change { movie.reload.duration }.from(movie.duration).to(params[:duration])
    end

    it { is_expected.to eq(movie) }

    it "returns the movie object without errors" do
      expect(update_movie.errors).to be_empty
    end

    context "when params are invalid" do
      let(:title) { nil }

      it "doesn't update the movie" do
        expect { update_movie }.not_to(change { movie.reload.title })
      end

      it { is_expected.to eq movie }

      it "returns the movie object with errors array not empty" do
        expect(update_movie.errors).not_to be_empty
      end

      it "returns the movie object with proper errors" do
        expect(update_movie.errors).to contain_exactly("Title can't be blank")
      end
    end
  end
end
