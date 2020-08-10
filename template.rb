# frozen_string_literal: true

require_relative 'support/support'

def source_paths
  [__dir__]
end

commented_files = %w[
  app/jobs/application_job.rb
  app/models/user.rb
  config/application.rb
  config/environment.rb
  config/routes.rb
  spec/rails_helper.rb
  spec/spec_helper.rb
  .gitignore
  config.ru
  Gemfile
  Rakefile
]

commented_config_files = %w[
  config/environments/development.rb
  config/environments/production.rb
  config/environments/test.rb
  config/initializers/application_controller_renderer.rb
  config/initializers/backtrace_silencers.rb
  config/initializers/content_security_policy.rb
  config/initializers/cookies_serializer.rb
  config/initializers/devise.rb
  config/initializers/filter_parameter_logging.rb
  config/initializers/inflections.rb
  config/initializers/mime_types.rb
  config/initializers/rolify.rb
  config/initializers/wrap_parameters.rb
  config/locales/en.yml
  config/boot.rb
  config/database.yml
  config/puma.rb
  config/routes.rb
  config/storage.yml
  config/webpacker.yml
  lib/tasks/auto_annotate_models.rake
]

commented_js_files = %w[
  app/javascript/channels/consumer.js
  app/javascript/channels/index.js
  app/javascript/controllers/index.js
  app/javascript/packs/application.js
]

multiple_whitespace_files = %w[
  config/environments/production.rb
  config/environments/test.rb
  config/puma.rb
]

yarn_dev_packages = %w[
  babel-eslint
  eslint
  eslint-config-airbnb-base
  eslint-config-prettier
  eslint-import-resolver-webpack
  eslint-plugin-import
  eslint-plugin-prettier
  prettier
  stylelint
  stylelint-config-sass-guidelines
  stylelint-config-standard
  stylelint-scss
]

yarn_packages = %w[
  @fortawesome/fontawesome-free
  bootstrap
  jquery
  jquery-ujs
  popper.js
  postcss-import
  postcss-flexbugs-fixes
  postcss-preset-env
  turbolinks
]

remove_dir 'app/assets'
remove_file 'db/seeds.rb'
remove_file 'app/views/layouts/application.html.erb'

directory 'files', './'
directory 'insert_files', 'insert_files'

gsub_file 'Gemfile',
          "gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]",
          ''

gem_group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'fasterer'
  gem 'flay'
  gem 'overcommit'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubycritic', require: false
  gem 'slim_lint'
end

gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'meta_request'
  gem 'pry-awesome_print'
  gem 'pry-rails'
end

gem_group :development, :test do
  gem 'amazing_print'
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

gem_group :test do
  gem 'capybara'
  gem 'geckodriver-helper'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'w3c_validators'
  gem 'webmock'
end

gem_group :development do
  gem 'annotate'
  gem 'seedbank'
end

gem 'devise'
gem 'rolify'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'slim-rails'
gem 'mailgun-ruby'

run 'bundle install'

after_bundle do
  # Add yarn packages
  run "yarn add --dev #{yarn_dev_packages.join(' ')}"
  run "yarn add #{yarn_packages.join(' ')}"

  # Create DB
  rails_command 'db:drop'
  rails_command 'db:create'
  rails_command 'db:migrate'

  # Configure .gitignore
  append_to_file '.gitignore', File.read('./insert_files/.gitignore')

  # Remove redundant generated files
  remove_file 'app/javascript/controllers/hello_controller.js'

  # Configure bullet gem
  inject_into_file(
    'config/environments/development.rb',
    File.read('./insert_files/config/environments/development_bullet.rb'),
    after: "ActiveSupport::EventedFileUpdateChecker\n"
  )

  # RSpec
  generate 'rspec:install'
  append_to_file '.rspec', "--format documentation\n--color\n"
  run 'rubocop spec/spec_helper.rb --auto-correct-all'
  prepend_to_file 'spec/rails_helper.rb',
                  "require 'simplecov'\nSimpleCov.start\n\n"

  inject_into_file 'spec/rails_helper.rb',
                   File.read('./insert_files/spec/rails_helper.rb'),
                   after: "require 'rspec/rails'\n"

  # Devise
  generate 'devise:install'

  inject_into_file(
    'config/initializers/devise.rb',
    File.read('./insert_files/config/initializers/devise.rb'),
    after: "config.sign_out_via = :delete\n"
  )

  inject_into_file(
    'config/environments/development.rb',
    File.read('./insert_files/config/environments/development_mailer.rb'),
    after: "config.action_mailer.perform_caching = false\n"
  )

  generate 'devise User'
  uncomment_lines Dir['./db/migrate/*_devise_create_users.rb'].first,
                  /t\.|add/

  generate 'rolify Role User'
  rails_command 'db:migrate'
  uncomment_lines 'config/initializers/rolify.rb',
                  /config.use_dynamic_shortcuts/

  remove_file_comments 'app/models/user.rb'

  gsub_file 'app/models/user.rb',
            'devise :database_authenticatable, :registerable,',
            ''

  gsub_file 'app/models/user.rb',
            ':recoverable, :rememberable, :validatable',
            ''

  inject_into_file 'app/models/user.rb',
                   File.read('./insert_files/app/models/user_devise.rb'),
                   after: "rolify\n"

  gsub_file 'config/routes.rb',
            'devise_for :users',
            File.read('./insert_files/config/routes_devise.rb')

  copy_file 'files/app/controllers/users/omniauth_callbacks_controller.rb',
            'app/controllers/users/omniauth_callbacks_controller.rb'

  inject_into_file 'spec/factories/users.rb',
                   File.read('./insert_files/spec/factories/users.rb'),
                   after: "factory :user do\n"

  inject_into_file 'spec/factories/roles.rb',
                   "\nname { 'MyString' }",
                   after: "factory :role do\n"

  # I18n
  inject_into_file(
    'app/controllers/application_controller.rb',
    File.read('./insert_files/app/controllers/application_controller_i18n.rb'),
    after: "class ApplicationController < ActionController::Base\n"
  )

  # Annotate
  generate 'annotate:install'
  remove_file 'lib/tasks/.keep'

  # Remove comments
  change_files commented_files, :remove_file_comments
  change_files commented_config_files,
               :remove_file_comments,
               delete_blank_lines: true
  change_files multiple_whitespace_files, :remove_file_whitespaces
  change_files commented_js_files, :remove_js_file_comments
  remove_file_inline_comments 'config/boot.rb'

  # Fix js files
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'

  # JS
  prepend_to_file(
    'app/javascript/packs/application.js',
    File.read('./insert_files/app/javascript/packs/application.js')
  )

  # Provide plugin
  inject_into_file(
    'config/webpack/environment.js',
    File.read('./insert_files/config/webpack/environment.js'),
    after: "const { environment } = require('@rails/webpacker')\n"
  )

  # Remove insert files
  remove_dir 'insert_files'

  # Run autocorrection
  run 'rubocop --auto-correct-all'
  run 'yarn run eslint . --fix'
  run 'annotate'

  # Initialize git, install overcommit and commit
  run 'overcommit --install'
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
