# frozen_string_literal: true

def install_devise
  @process = __method__.to_s

  install_gems

  configure_devise
  configure_rolify
  configure_users
  configure_routes

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
end
