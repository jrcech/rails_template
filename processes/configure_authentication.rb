def configure_authentication
  uncomment_lines 'Gemfile', /bcrypt/

  configure_authentication_routes
  configure_development_mailer
  configure_test_mailer
  include_authentication_concern

  process_directory
end

def configure_authentication_routes
  template_into_file(
    'config/routes.rb',
    after: "scope '(:locale)', locale: /en|cs/ do\n"
  )
end

def configure_development_mailer
  template_into_file(
    'config/environments/development.rb',
    after: "config.action_mailer.perform_caching = false\n"
  )
end

def configure_test_mailer
  template_into_file(
    'config/environments/test.rb',
    after: "config.action_mailer.delivery_method = :test\n"
  )
end

def include_authentication_concern
  template_into_file(
    'app/controllers/application_controller.rb',
    after: "class ApplicationController < ActionController::Base\n"
  )
end
