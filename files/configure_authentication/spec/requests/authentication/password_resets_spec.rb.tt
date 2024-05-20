require 'rails_helper'

RSpec.describe 'PasswordResets' do
  describe 'GET /new' do
    before do
      get new_password_reset_url
    end

    it 'has a status of ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes "Reset Password" in the body' do
      expect(response.body).to include('Reset Password')
    end
  end

  describe 'GET /edit' do
    context 'with valid token' do
      let(:user) { create(:user) }
      let(:token) { user.generate_token_for(:password_reset) }

      before do
        get edit_password_reset_url(token:)
      end

      it 'has a status of ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'includes "Reset Password" in the body' do
        expect(response.body).to include('Reset Your Password')
      end
    end

    context 'with invalid token' do
      it 'redirects to the new password reset page' do
        get edit_password_reset_url(token: 'invalid_token')

        expect(response).to redirect_to(new_password_reset_url)
      end
    end
  end

  describe 'POST /create' do
    let(:user) { create(:user) }

    describe 'password reset email' do
      let(:password_reset_mailer) { instance_double(ActionMailer::MessageDelivery) }
      let(:mailer_class) { class_double(PasswordMailer).as_stubbed_const }

      before do
        allow(mailer_class).to receive_messages(
          with: mailer_class,
          password_reset: password_reset_mailer
        )

        allow(password_reset_mailer).to receive(:deliver_later)

        post password_reset_url, params: { email: user.email }
      end

      it 'calls PasswordMailer.with with correct parameters' do
        expect(mailer_class).to have_received(:with).with(hash_including(:user, :token))
      end

      it 'calls password_reset on the mailer' do
        expect(mailer_class).to have_received(:password_reset)
      end

      it 'calls deliver_later on the mailer' do
        expect(password_reset_mailer).to have_received(:deliver_later)
      end
    end

    it 'redirects to the root url' do
      post password_reset_url, params: { email: user.email }

      expect(response).to redirect_to(root_url(locale: :en))
    end

    it 'sets an info flash message' do
      post password_reset_url, params: { email: user.email }

      expect(flash[:info]).to eq('Password reset email sent')
    end
  end

  describe 'PUT /update' do
    let(:user) { create(:user) }
    let(:token) { user.generate_token_for(:password_reset) }

    context 'with valid params' do
      before do
        put password_reset_url(token:), params: {
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
      end

      it 'updates the password' do
        user.reload

        expect(user.authenticate('new_password')).to be_truthy
      end

      it 'redirects to the new session url' do
        expect(response).to redirect_to(new_session_url)
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Password successfully reset')
      end
    end

    context 'with invalid params' do
      before do
        put password_reset_url(token:), params: {
          user: {
            password: 'new_password',
            password_confirmation: 'wrong_confirmation'
          }
        }
      end

      it 'does not update the password' do
        user.reload

        expect(user.authenticate('new_password')).to be_falsy
      end

      it 'returns unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'includes "Reset Password" in the body' do
        expect(response.body).to include('Reset Your Password')
      end
    end
  end
end
