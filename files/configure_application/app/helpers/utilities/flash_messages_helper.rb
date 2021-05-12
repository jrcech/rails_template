# frozen_string_literal: true

module Utilities
  module FlashMessagesHelper
    def flash_messages
      render 'application/components/flash_messages' if flash.present?
    end

    def bootstrap_flash(type)
      public_send(type)
    end

    def notice
      { class: 'info', icon: 'info-circle' }
    end

    def success
      { class: 'success', icon: 'check' }
    end

    def error
      { class: 'danger', icon: 'exclamation-triangle' }
    end

    alias alert error
  end
end
