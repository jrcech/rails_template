# frozen_string_literal: true

module LoginSupport
  def sign_in_user
    user = create(:user)
    sign_in user
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
