# frozen_string_literal: true

module <%= file_name.capitalize %>
  class <%= file_name.capitalize %>Controller < ActionController::Base
    before_action :authenticate_user!

    layout '<%= file_name %>'
  end
end
