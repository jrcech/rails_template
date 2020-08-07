# frozen_string_literal: true

module Utilities
  module DeviseHelper
    def email_for(resource)
      return resource.unconfirmed_email if resource.pending_reconfirmation?

      resource.email
    end

    def log_in
      return unless controller_name != 'sessions'

      construct_link('log_in', 'session')
    end

    def sign_up
      return unless devise_mapping.registerable?
      return unless controller_name != 'registrations'

      construct_link('sign_up', 'registration')
    end

    def forgot_password
      return unless devise_mapping.recoverable?
      return unless controller_name != 'passwords'
      return unless controller_name != 'registrations'

      construct_link('forgot_password', 'password')
    end

    def confirmation_instructions
      return unless devise_mapping.confirmable?
      return unless controller_name != 'confirmations'

      construct_link('confirmation_instructions', 'confirmation')
    end

    def unlock_instructions
      return unless devise_mapping.lockable?
      return unless resource_class.unlock_strategy_enabled?(:email)
      return unless controller_name != 'unlocks'

      construct_link('unlock_instructions', 'unlock')
    end

    def sign_in_with_provider
      return unless devise_mapping.omniauthable?

      construct_provider_links
    end

    private

    def construct_link(translation, path)
      link = link_to t("devise.shared.links.#{translation}"),
                     send("new_#{path}_path", resource_name)

      "#{link}</br>".html_safe
    end

    def construct_provider_links
      html = ''
      resource_class.omniauth_providers.each do |provider|
        html += link_to t('devise.shared.links.sign_with_provider',
                          provider: OmniAuth::Utils.camelize(provider)),
                        omniauth_authorize_path(resource_name, provider)
        html += '</br>'
      end

      html.html_safe
    end
  end
end
