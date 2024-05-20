module Helpers
  module Requests
    module Sessions
      def sign_in(user)
        post(
          session_path,
          params: {
            email: user.email,
            password: user.password
          }
        )
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::Requests::Sessions, type: :request
end
