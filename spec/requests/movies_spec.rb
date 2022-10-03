# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/movies', type: :request do
  let(:user) { create :user }
  let(:manager) { create :user, email: 'manager@gmail.com', role: :manager }
  before { request }
  describe 'GET /movies' do
    subject(:request) { get movies_url }

    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'renders proper template' do
      expect(response).to render_template('movies/index')
    end
  end

  describe 'GET /movies/movie_id' do
     let(:movie) { create :movie }
    subject(:request) { get("/movies/#{movie.id}") }
    it 'returns successful response' do
      expect(response.status).to eq(200)
    end
    it 'renders proper template' do
      expect(response).to render_template('movies/show')
    end
  end

  describe 'GET /movies/new' do
    context 'when user not signed in' do
      it 'redirects to sign_in' do
        get('/movies/new')
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'returns redirect status' do
        get('/movies/new')
        expect(response.status).to eq(302)
      end
    end

    context 'when user without permission' do
      before { sign_in user }
      it 'redirects to root' do
        get('/movies/new')
        expect(response).to redirect_to('/')
      end

      it 'returns redirect status' do
        get('/movies/new')
        expect(response.status).to eq(302)
      end
    end

    context 'when user with permission' do
      before { sign_in manager }
      it 'returns successful response' do
        get('/movies/new')
        expect(response.status).to eq(200)
      end

      it 'renders proper template' do
        get('/movies/new')
        expect(response).to render_template('movies/new')
      end
    end
  end

  describe 'POST /movies' do
    let(:params) do
      {
        movie: {
          title:,
          description: Faker::Movie.quote,
          duration:
        }
      }
    end

    let(:title) { Faker::Movie.title }
    let(:duration) { Faker::Number.number(digits: 2).to_i }

    context 'when user not signed in' do
      it 'redirects to sign_in' do
        post('/movies')
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'returns redirect status' do
        post('/movies')
        expect(response.status).to eq(302)
      end

      it 'does not create a movie' do
        expect { post('/movies', params:) }.not_to change(Movie, :count)
      end
    end

    context 'when user without permission' do
      before { sign_in user }
      it 'redirects to root' do
        post('/movies', params:)
        expect(response).to redirect_to('/')
      end

      it 'returns redirect status' do
        post('/movies')
        expect(response.status).to eq(302)
      end

      it 'does not create a movie' do
        expect { post('/movies', params:) }.not_to change(Movie, :count)
      end
    end

    context 'when user with permission' do
      before { sign_in manager }
      it 'returns redirect status' do
        post('/movies', params:)
        expect(response.status).to eq(302)
      end

      it 'redirects to movie/movie_id' do
        post('/movies', params:)
        expect(response).to redirect_to action: :show, id: assigns(:movie).id
      end

      it 'creates movie' do
        expect { post('/movies', params:) }.to change(Movie, :count).by(1)
      end
    end

    context 'when invalid params' do
      before { sign_in manager }
      let(:duration) { 'some string' }

      it "doesn't create movie" do
        expect { post('/movies', params:) }.not_to change(Movie, :count)
      end

      it 'returns unsuccessful response' do
        post('/movies', params:)
        expect(response.status).to eq(422)
      end

      let(:title) { nil }

      it "doesn't create movie" do
        expect { post('/movies', params:) }.not_to change(Movie, :count)
      end

      it 'returns unsuccessful response' do
        post('/movies', params:)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET /movies/movie_id/edit' do
    let(:movie) { create :movie }
    context 'when no user' do
      it 'redirects to sign_in' do
        get("/movies/#{movie.id}/edit")
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'returns redirect status' do
        get("/movies/#{movie.id}/edit")
        expect(response.status).to eq(302)
      end
    end

    context 'when user without permission' do
      before { sign_in user }
      it 'redirects to root' do
        get("/movies/#{movie.id}/edit")
        expect(response).to redirect_to('/')
      end

      it 'returns redirect status' do
        get("/movies/#{movie.id}/edit")
        expect(response.status).to eq(302)
      end
    end

    context 'when user with permission' do
      before { sign_in manager }
      it 'returns successful response' do
        get("/movies/#{movie.id}/edit")
        expect(response.status).to eq(200)
      end

      it 'renders proper template' do
        get("/movies/#{movie.id}/edit")
        expect(response).to render_template('movies/edit')
      end
    end
  end

  describe 'PATCH /movies' do
    let(:movie) { create :movie }
    let(:params) do
      {
        movie: {
          title:,
          description: Faker::Movie.quote,
          duration:
        }
      }
    end

    let(:title) { Faker::Movie.title }
    let(:duration) { Faker::Number.number(digits: 2).to_i }

    context 'when user not signed in' do
      it 'redirects to sign_in' do
        patch("/movies/#{movie.id}", params:)
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'returns redirect status' do
        patch("/movies/#{movie.id}")
        expect(response.status).to eq(302)
      end
    end

    context 'when user without permission' do
      before { sign_in user }
      it 'redirects to root' do
        patch("/movies/#{movie.id}", params:)
        expect(response).to redirect_to('/')
      end

      it 'returns redirect status' do
        patch("/movies/#{movie.id}")
        expect(response.status).to eq(302)
      end
    end

    context 'when user with permission' do
      before { sign_in manager }
      it 'returns redirect status' do
        patch("/movies/#{movie.id}", params:)
        expect(response.status).to eq(302)
      end

      it 'redirects to movie/movie_id' do
        patch("/movies/#{movie.id}", params:)
        expect(response).to redirect_to action: :show, id: assigns(:movie).id
      end

      it 'updates movie' do
        expect { patch("/movies/#{movie.id}", params:) }.to change {
                                                              movie.reload.title
                                                            }.from(movie.title).to(title.to_s)
      end
    end

    context 'when invalid params' do
      before { sign_in manager }
      let(:duration) { 'some string' }

      it "doesn't update movie" do
        expect { patch("/movies/#{movie.id}", params:) }.not_to(change { movie.reload.title })
      end

      it 'returns unsuccessful response' do
        patch("/movies/#{movie.id}", params:)
        expect(response.status).to eq(422)
      end

      let(:duration) { Faker::Number.number(digits: 2).to_i }
      let(:title) { nil }

      it "doesn't update movie" do
        expect { patch("/movies/#{movie.id}", params:) }.not_to(change { movie.reload.title })
      end

      it 'returns unsuccessful response' do
        patch("/movies/#{movie.id}", params:)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /movies' do
    let(:movie) { create :movie }
    context 'when no user' do
      it 'redirects to sign_in' do
        delete("/movies/#{movie.id}")
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'returns redirect status' do
        delete("/movies/#{movie.id}")
        expect(response.status).to eq(302)
      end
    end

    context 'when user without permission' do
      before { sign_in user }
      it 'redirects to root' do
        delete("/movies/#{movie.id}")
        expect(response).to redirect_to('/')
      end

      it 'returns redirect status' do
        delete("/movies/#{movie.id}")
        expect(response.status).to eq(302)
      end
    end

    context 'when user with permission' do
      before { sign_in manager }
      it 'returns redirect status' do
        delete("/movies/#{movie.id}")
        expect(response.status).to eq(302)
      end

      it 'redirects to /movies' do
        delete("/movies/#{movie.id}")
        expect(response).to redirect_to('/movies')
      end

      it 'destroy movie' do
        expect { delete("/movies/#{movie.id}") }.to change { Movie.count }.by(-1)
      end
      
    end
  end
end
