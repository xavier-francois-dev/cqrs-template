

require 'rails_helper'

RSpec.describe 'Session authentication', type: :request do
  describe 'signup' do
    context 'with invalid params' do
      let(:params) { { user: { email: 'invalid', password: 'short' } } }

      it 'returns a 422 error' do
        post '/signup', params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid params' do
      let(:params) do
        { user: { email: 'a@b.com', password: 'Password1!', password_confirmation: 'Password1!' } }
      end

      before do
        post '/signup', params: params
      end

      it 'creates a user and returns the right status' do
        expect(response).to have_http_status(:created)
        json = response.parsed_body
        expect(json.dig('user', 'email')).to eq('a@b.com')
      end
    end
  end
end
