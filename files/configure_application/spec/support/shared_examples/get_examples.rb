# frozen_string_literal: true

RSpec.shared_examples 'GET examples' do |path|
  describe "GET #{path}" do
    context 'with a guest' do
      before do
        get path
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        expect(response).to have_http_status :ok
      end
    end

    context 'with an authenticated user' do
      before do
        sign_in_user
        get path
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        expect(response).to have_http_status :ok
      end
    end
  end
end
