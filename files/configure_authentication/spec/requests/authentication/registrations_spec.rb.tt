require 'rails_helper'

RSpec.describe 'Registrations' do
  describe 'GET /new' do
    before { get new_registration_url }

    it 'has HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the new registration page' do
      expect(response.body).to include('Sign Up')
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          user: {
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'creates a new User' do
        expect do
          post registration_url, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'redirects to root' do
        post registration_url, params: valid_params

        expect(response).to redirect_to(root_url(locale: :en))
      end

      it 'displays a signed-in notice after redirect' do
        post registration_url, params: valid_params

        follow_redirect!

        expect(response.body).to include('Signed in')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          user: {
            email: 'test@example',
            password: 'password',
            password_confirmation: 'wrong_password'
          }
        }
      end

      it 'does not create a new User' do
        expect do
          post registration_url, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'responds with unprocessable entity status' do
        post registration_url, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the new registration page' do
        post registration_url, params: invalid_params

        expect(response.body).to include('Sign Up')
      end
    end
  end
end
