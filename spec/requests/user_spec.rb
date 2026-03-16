require 'rails_helper'

RSpec.describe 'Users', type: :request do

  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'POST /api/v1/users' do
    context 'with valid params' do
      it 'creates a user and returns 201' do
        post '/api/v1/users', params: {
          user: { name: 'John', email: 'john@gmail.com', password: '123456' }
        }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('John')
      end
    end

    context 'with invalid params' do
      it 'returns 422 with errors' do
        post '/api/v1/users', params: {
          user: { name: nil, email: 'john@gmail.com', password: '123456' }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end

  describe 'GET /api/v1/users/:id' do
    context 'authenticated' do
      it 'returns the user and 200' do
        get "/api/v1/users/#{user.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['email']).to eq(user.email)
      end

      it 'returns 404 for wrong id' do
        get '/api/v1/users/99999', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        get "/api/v1/users/#{user.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/users/:id' do
    context 'authenticated' do
      it 'updates the user and returns 200' do
        put "/api/v1/users/#{user.id}", params: {
          user: { name: 'Updated Name' }
        }, headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['name']).to eq('Updated Name')
      end

      it 'returns 422 with invalid params' do
        put "/api/v1/users/#{user.id}", params: {
          user: { name: nil }
        }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns 404 for wrong id' do
        put '/api/v1/users/99999', params: {
          user: { name: 'test' }
        }, headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        put "/api/v1/users/#{user.id}", params: { user: { name: 'test' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    context 'authenticated' do
      it 'deletes the user and returns 200' do
        delete "/api/v1/users/#{user.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("User with name #{user.name} has been deleted")
      end

      it 'returns 404 for wrong id' do
        delete '/api/v1/users/99999', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        delete "/api/v1/users/#{user.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end