require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:user) { create(:user, password: 'password') }

  describe 'GET /new' do
    before { get new_session_url }

    it 'has HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the new session page' do
      expect(response.body).to include('Log in')
    end
  end

  describe 'POST /create' do
    context 'with valid credentials' do
      before { post session_url, params: { email: user.email, password: 'password' } }

      it 'redirects to the root url' do
        expect(response).to redirect_to(root_url(locale: :en))
      end

      it 'displays a signed-in notice after redirect' do
        follow_redirect!

        expect(response.body).to include('Signed in')
      end
    end

    context 'with invalid credentials' do
      before { post session_url, params: { email: user.email, password: 'wrong_password' } }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'displays an error message' do
        expect(response.body).to include('Incorrect email or password')
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      post session_url, params: { email: user.email, password: 'password' }

      delete session_url
    end

    it 'redirects to the root url' do
      expect(response).to redirect_to(root_url(locale: :en))
    end

    it 'displays a signed-out notice after redirect' do
      follow_redirect!

      expect(response.body).to include('Signed out')
    end
  end
end
