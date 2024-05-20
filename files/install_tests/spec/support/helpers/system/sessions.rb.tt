module Helpers
  module System
    module Sessions
      def sign_in(user)
        visit new_session_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_on 'Log in'

        expect(page).to have_content('Homepage#index')
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::System::Sessions, type: :system
end
