require 'rails_helper'

RSpec.describe PasswordMailer do
  describe '#password_reset' do
    let(:user) { create(:user) }
    let(:token) { user.generate_token_for(:password_reset) }

    let(:mail) do
      described_class.with(user:, token:).password_reset
    end

    it 'renders the headers' do
      aggregate_failures do
        expect(mail.subject).to eq('Password Reset')
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(['from@example.com'])
      end
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('We received a request to reset the password for your account.')
    end

    it 'contains the reset password link' do
      expect(mail.body.encoded).to include(edit_password_reset_url(token:))
    end
  end
end
