# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::Update do
  let!(:movie) { create :movie }
  let(:params) do
    {
      title:,
      description: Faker::Movie.quote,
      duration: Faker::Number.number(digits: 2).to_i
    }
  end
  let(:title) { Faker::Movie.title }

  subject { described_class.new(movie.id, params).call }

  describe '.call' do
    it 'updates movie' do
      expect { subject }
        .to change { movie.reload.title }.from(movie.title).to(title)
        .and change { movie.reload.description }.from(movie.description).to(params[:description])
        .and change { movie.reload.duration }.from(movie.duration).to(params[:duration])
    end

    it { is_expected.to eq(movie) }

    it 'returns movie object without errors' do
      expect(subject.errors).to be_empty
    end

    context 'when params invalid' do
      let(:title) { nil }

      it "doesn't update movie" do
        expect { subject }.not_to change { movie.reload.title }
      end

      it { is_expected.to eq movie }

      it 'returns movie object with errors array not empty' do
        expect(subject.errors).not_to be_empty
      end

      it 'returns movie object with proper errors' do
        expect(subject.errors).to match_array(["Title can't be blank"])
      end
    end
  end
end
