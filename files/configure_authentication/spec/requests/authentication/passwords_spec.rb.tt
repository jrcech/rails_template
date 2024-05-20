require 'rails_helper'

RSpec.describe 'Passwords' do
  let(:user) { create(:user, password: 'old_password') }

  before do
    sign_in(user)
  end

  describe 'GET /edit' do
    before { get edit_password_url }

    it 'responds with HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the edit password page' do
      expect(response.body).to include('Update Password')
    end
  end

  describe 'PUT /update' do
    context 'with valid params' do
      let(:valid_params) do
        {
          password: 'new_password',
          password_confirmation: 'new_password',
          password_challenge: 'old_password'
        }
      end

      before { put password_url, params: { user: valid_params } }

      it 'responds with a redirect to the edit url' do
        expect(response).to redirect_to(edit_password_url)
      end

      it 'shows a successful update notice' do
        follow_redirect!

        expect(response.body).to include('Password successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          password: 'new_password',
          password_confirmation: 'wrong_password',
          password_challenge: 'old_password'
        }
      end

      before { put password_url, params: { user: invalid_params } }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'stays on the edit password page' do
        expect(response.body).to include('Password confirmation')
      end
    end
  end
end
