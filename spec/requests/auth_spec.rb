require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /api/v1/auth/login' do
    let(:user) { create(:user) }

    context 'with valid credentials' do
      it 'returns a token and 200' do
        post '/api/v1/auth/login', params: { email: user.email, password: '123456' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid password' do
      it 'returns 401 unauthorized' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'wrongpassword' }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid email' do
      it 'returns 401 unauthorized' do
        post '/api/v1/auth/login', params: { email: 'wrong@gmail.com', password: '123456' }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end