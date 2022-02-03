# frozen_string_literal: true

def install_devise
  install_gems

  configure_devise
  configure_rolify
  configure_users
  configure_routes
  configure_rspec
  configure_controllers
  configure_mailer

  process_directory

  run 'rails db:migrate'
end

def configure_devise
  run 'rails generate devise:install'
  remove_file 'config/locales/devise.en.yml'

  template_into_file(
    'config/initializers/devise.rb',
    after: "config.sign_out_via = :delete\n"
  )

  generate_devise_user
end

def generate_devise_user
  run 'rails generate devise User'
  uncomment_lines Dir['./db/migrate/*_devise_create_users.rb'].first, /t\.|add/
end

def configure_rolify
  run 'rails generate rolify Role User'

  uncomment_lines(
    'config/initializers/rolify.rb',
    'config.use_dynamic_shortcuts'
  )

  configure_roles_factory
end

def configure_roles_factory
  template_into_file(
    'spec/factories/roles.rb',
    after: "factory :role do\n"
  )
end

def configure_users
  generate_user_migrations
  configure_user_model
  configure_user_spec
  configure_users_factory
end

def generate_user_migrations
  run 'rails generate migration AddNameToUser first_name last_name username'
  run 'rails generate migration AddOmniauthToUser provider uid'
end

def configure_user_model
  remove_lines 'app/models/user.rb', 'devise :database_authenticatable'
  remove_lines 'app/models/user.rb', ':recoverable'
  remove_lines 'app/models/user.rb', 'rolify'

  template_into_file(
    'app/models/user.rb',
    after: "class User < ApplicationRecord\n"
  )
end

def configure_user_spec
  template_into_file 'spec/models/user_spec.rb', before: last_end
end

def configure_users_factory
  template_into_file(
    'spec/factories/users.rb',
    after: "factory :user do\n"
  )
end

def configure_routes
  remove_lines 'config/routes.rb', 'devise_for :users'

  template_into_file(
    'config/routes.rb',
    after: "Rails.application.routes.draw do\n"
  )

  insert_into_file(
    'config/routes.rb',
    read_insert_file('config/routes_devise_for'),
    after: "scope '(:locale)'"
  )
end

def configure_rspec
  template_into_file(
    'spec/support/shared_examples/requests/get_index_examples.rb',
    before: second_last_end
  )

  gsub_file(
    'spec/requests/admin/dashboard_request_spec.rb',
    'GET /index',
    'GET /index authenticated'
  )
end

def configure_controllers
  template_into_file(
    'app/controllers/admin/admin_controller.rb',
    after: "class AdminController < ApplicationController\n"
  )
end

def configure_mailer
  template_into_file(
    'config/environments/development.rb',
    after: "config.action_mailer.perform_caching = false\n"
  )

  template_into_file(
    'config/environments/test.rb',
    after: "config.action_mailer.perform_caching = false\n"
  )
end

def configure_flash_messages
  template_into_file(
    'app/views/layouts/admin.rb',
    after: "body\n"
  )

  template_into_file(
    'app/views/layouts/application.rb',
    after: "body\n"
  )
end
