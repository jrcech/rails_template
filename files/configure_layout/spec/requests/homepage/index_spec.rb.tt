require 'rails_helper'

RSpec.describe '/root' do
  let(:admin) { create(:user) }

  describe 'GET /index' do
    context 'when authorized' do
      before do
        sign_in admin

        get root_url
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'renders a response with 200 :ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when public' do
      before do
        get root_url
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'renders a response with 200 :ok status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
