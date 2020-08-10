# frozen_string_literal: true

RSpec.shared_examples 'OmniAuth examples' do |service|
  service_name = service.to_s.humanize(capitalize: false)

  describe service_name do
    before do
      OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new(
        info: {
          email: 'john.doe@example.com',
          first_name: 'John',
          last_name: 'Doe'
        }
      )
    end

    after do
      OmniAuth.config.mock_auth[service] = nil
    end

    it 'signs in with valid credentials' do
      OmniAuth.config.add_mock(service, uid: '12345')
      ominauth_sign_in(service_name)
      expect(
        page
      ).to have_text "authenticated from #{service_name.capitalize}"
    end

    it 'fails with invalid credentials' do
      OmniAuth.config.mock_auth[service] = :invalid_credentials
      ominauth_sign_in(service_name)
      expect(
        page
      ).not_to have_text "authenticated from #{service_name.capitalize}"
    end

    context 'without email' do
      before do
        OmniAuth.config.add_mock(service, uid: '12345')
        OmniAuth.config.mock_auth[service].info.email = nil
        ominauth_sign_in(service_name)
      end

      it 'redirects to sign up' do
        expect(page).to have_text 'Sign Up'
      end

      it 'stores auth data to session' do
        session_data = page.driver.request.session["devise.#{service}_data"]
        expect(session_data).not_to be_empty
      end
    end

    def ominauth_sign_in(service_name)
      visit new_user_session_path
      click_link "Sign in with #{service_name.capitalize}"
    end
  end
end
