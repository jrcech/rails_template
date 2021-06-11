# frozen_string_literal: true

def configure_application
  append_to_file '.gitignore', File.read('./tmp/inserts/configure_application/.gitignore')

  remove_file 'db/seeds.rb'
  remove_file 'app/views/layouts/application.html.erb'

  directory 'files/configure_application', './'

  # Config application generators
  gsub_file(
    'config/application.rb',
    'config.generators.system_tests = nil',
    File.read('./tmp/inserts/configure_application/config/application')
  )

  # Config mailer
  inject_into_file(
    'config/environments/development.rb',
    File.read('./tmp/inserts/configure_application/config/environments/development'),
    after: "config.action_mailer.perform_caching = false\n"
  )
  inject_into_file(
    'config/environments/test.rb',
    File.read('./tmp/inserts/configure_application/config/environments/test'),
    after: "config.action_mailer.perform_caching = false\n"
  )

  # I18n
  inject_into_file(
    'app/controllers/application_controller.rb',
    File.read('./tmp/inserts/configure_application/app/controllers/application_controller'),
    after: "class ApplicationController < ActionController::Base\n"
  )

  # Install gems
  append_to_file 'Gemfile', File.read('./tmp/inserts/configure_application/Gemfile')
  run 'bundle install'

  # Install Stimulus and Turbo
  run 'rails hotwire:install'

  # Annotate
  run 'rails generate annotate:install'
  remove_file 'lib/tasks/.keep'

  # ERD
  run 'rails generate erd:install'

  # Fix js files
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'

  # JS
  prepend_to_file(
    'app/javascript/packs/application.js',
    File.read('./tmp/inserts/configure_application/app/javascript/packs/application')
  )

  # Provide plugin
  inject_into_file(
    'config/webpack/environment.js',
    File.read('./tmp/inserts/configure_application/config/webpack/environment'),
    after: "const { environment } = require('@rails/webpacker')\n"
  )
end
