# frozen_string_literal: true

def source_paths
  [__dir__]
end

def remove_file_comments(file, options = {})
  if options[:delete_blank_lines]
    regex = /^\s*#.*$\n/
  else
    regex = /^[ ]*#.*$\n/
  end

  gsub_file(file, regex, '')
end

def remove_js_file_comments(file, options = {})
  if options[:delete_blank_lines]
    regex = /^\s*\/\/.*$\n/
  else
    regex = /^[ ]*\/\/.*$\n/
  end

  gsub_file(file, regex, '')
end

def remove_file_inline_comments(file, options = {})
  gsub_file(file, /#[\w\s]*\./, '')
end

def remove_file_whitespaces(file, options = {})
  gsub_file(file, /\S\K([ ]{2,})/, ' ')
end

def change_files(files, change_file_method, options = {})
  files.each do |file|
    send(change_file_method, file, options)
  end
end

def rubocop_file(file)
  run("rubocop -a #{file}")
end

def rubocop_correct_all
  run('rubocop -a')
end

def eslint
  run('yarn run eslint --fix .')
end

def append_to_file_line(file, search_line, append_string)
  replace_string = "#{search_line}#{append_string}"
  gsub_file(file, search_line, replace_string)
end

def append_to_text(file, search_text, append_string)
  replace_string = "#{search_text}#{append_string}"
  gsub_file(file, search_text, replace_string)
end

gitignore_files = %w[
    .DS_Store
    .idea
    .env
    .env.*
    /coverage
]

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

bullet_environment_settings = %(
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end
)

remove_dir 'app/assets'
remove_file 'db/seeds.rb'
remove_file 'app/views/layouts/application.html.erb'

copy_file 'files/.rubocop.yml', '.rubocop.yml'
copy_file 'files/.rails_best_practices.yml', '.rails_best_practices.yml'
copy_file 'files/.reek.yml', '.reek.yml'
copy_file 'files/.overcommit.yml', '.overcommit.yml'
copy_file 'files/.eslintrc', '.eslintrc'
copy_file 'files/procfile', 'procfile'
directory 'files/spec/support', 'spec/support'
directory 'files/spec/system', 'spec/system'
directory 'files/app/helpers/utilities', 'app/helpers/utilities'
directory 'files/app/controllers/admin', 'app/controllers/admin'
directory 'files/app/views', 'app/views'
copy_file 'files/config/initializers/locale.rb', 'config/initializers/locale.rb'
copy_file 'files/app/javascript/controllers/frontend_test_controller.js',
          'app/javascript/controllers/frontend_test_controller.js'
directory 'files/config/webpack/plugins',
          'config/webpack/plugins'
directory 'files/app/javascript/stylesheets',
          'app/javascript/stylesheets'

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
  append_to_file '.gitignore', +"\n" << gitignore_files.join("\n") << +"\n"

  # Remove redundant generated files
  remove_file 'app/javascript/controllers/hello_controller.js'

  # Configure bullet gem
  append_to_file_line 'config/environments/development.rb',
                      'ActiveSupport::EventedFileUpdateChecker',
                      bullet_environment_settings

  # RSpec
  generate 'rspec:install'
  append_to_file '.rspec', "--format documentation\n--color\n"
  run 'rubocop spec/spec_helper.rb --auto-correct-all'
  prepend_to_file 'spec/rails_helper.rb', "require 'simplecov'\nSimpleCov.start\n\n"

  rails_helper_inject = %(
    require 'capybara/rails'

    Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
  )
  append_to_file_line 'spec/rails_helper.rb',
                      "require 'rspec/rails'",
                      rails_helper_inject

  # Devise
  generate 'devise:install'

  devise_config = %(
    config.lock_strategy = :failed_attempts
    config.unlock_keys = [:email]
    config.unlock_strategy = :email
    config.maximum_attempts = 10
    config.last_attempt_warning = true
    config.omniauth :facebook,
                    Rails.application.credentials.dig(:omniauth, :facebook_app_id),
                    Rails.application.credentials.dig(:omniauth, :facebook_app_secret)
    config.omniauth :google_oauth2,
                    Rails.application.credentials.dig(:omniauth, :google_client_id),
                    Rails.application.credentials.dig(:omniauth, :google_client_secret),
                    name: :google
  )
  append_to_file_line(
      'config/initializers/devise.rb',
      'config.sign_out_via = :delete',
      devise_config
  )
  append_to_file_line 'config/environments/development.rb',
                      'config.action_mailer.perform_caching = false',
                      %(
                          config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
                          config.action_mailer.delivery_method = :letter_opener
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

  devise_user_model = %(
    devise :database_authenticatable,
           :registerable,
           :recoverable,
           :rememberable,
           :validatable,
           :trackable,
           :confirmable,
           :lockable,
           :omniauthable,
           omniauth_providers: %i[facebook google]

    after_create :assign_default_role

    def assign_default_role
      add_role(:user) if roles.blank?
    end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        process_user(user, auth)
        user.skip_confirmation!
      end
    end

    def self.process_user(user, auth)
      info = auth.info

      user.email = info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = info.first_name
      user.last_name = info.last_name
    end
  )
  append_to_file_line 'app/models/user.rb',
                      'rolify',
                      devise_user_model

  devise_routes = %(
    devise_for :users,
               only: :omniauth_callbacks,
               controllers: {
                 omniauth_callbacks: 'users/omniauth_callbacks'
               }

     scope '(:locale)', locale: /en|cs/ do
       devise_for :users, skip: :omniauth_callbacks

       namespace :admin do
         get :frontend_test, to: 'frontend_test#index'
         root to: 'dashboard#index'
       end

       get '/:locale', to: 'admin/dashboard#index'
       root to: 'admin/frontend_test#index'
     end

  )

  gsub_file 'config/routes.rb',
            'devise_for :users',
            devise_routes

  copy_file 'files/app/controllers/users/omniauth_callbacks_controller.rb',
            'app/controllers/users/omniauth_callbacks_controller.rb'

  users_factory = %(
    email { 'user@example.com' }
    password { 'MyString' }
    reset_password_token { 'MyString' }
    reset_password_sent_at { '2019-03-08 15:33:28' }
    remember_created_at { '2019-03-08 15:33:28' }
    sign_in_count { 1 }
    current_sign_in_at { '2019-03-08 15:33:28' }
    last_sign_in_at { '2019-03-08 15:33:28' }
    current_sign_in_ip { '' }
    last_sign_in_ip { '' }
    confirmation_token { 'MyString' }
    confirmed_at { '2019-03-08 15:33:28' }
    confirmation_sent_at { '2019-03-08 15:33:28' }
    unconfirmed_email { 'MyString' }
    created_at { '2019-03-08 15:33:28' }
    updated_at { '2019-03-08 15:33:28' }
  )

  append_to_text 'spec/factories/users.rb',
                 'factory :user do',
                 users_factory

  append_to_text 'spec/factories/roles.rb',
                 'factory :role do',
                 "\nname { 'MyString' }"

  # I18n
  i18n_config = %(
    before_action :set_locale

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options
      { locale: I18n.locale }
    end
  )

  append_to_text 'app/controllers/application_controller.rb',
                 'class ApplicationController < ActionController::Base',
                 i18n_config

  # Annotate
  generate 'annotate:install'
  remove_file 'lib/tasks/.keep'

  # Remove comments
  change_files commented_files, :remove_file_comments
  change_files commented_config_files, :remove_file_comments, delete_blank_lines: true
  change_files multiple_whitespace_files, :remove_file_whitespaces
  change_files commented_js_files, :remove_js_file_comments
  remove_file_inline_comments 'config/boot.rb'

  # Fix js files
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'

  # Run autocorrection
  run 'rubocop --auto-correct-all'
  run 'yarn run eslint . --fix'
  run 'annotate'

  # JS
  js_config = %(
    import "stylesheets/application.scss";
    import "jquery";
    import "jquery-ujs";
    import "bootstrap";
    import "@fortawesome/fontawesome-free/js/all";

    require("turbolinks").start();
  )

  append_to_text 'app/javascript/packs/application.js',
                 %(import "controllers";),
                 js_config

  # Provide plugin
  provide_config = %(
    const pluginProvide = require("./plugins/provide");

    environment.plugins.prepend("Provide", pluginProvide.plugin);
  )

  append_to_text 'config/webpack/environment.js',
                 %(const { environment } = require("@rails/webpacker");),
                 provide_config

  # Initialize git, install overcommit and commit
  run 'overcommit --install'
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
