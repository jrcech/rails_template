# frozen_string_literal: true

require_relative 'support/support'
require_relative 'support/commented_config_files'
require_relative 'support/commented_files'
require_relative 'support/commented_js_files'
require_relative 'support/multiple_whitespace_files'
require_relative 'support/yarn_dev_packages'
require_relative 'support/yarn_packages'

def source_paths
  [__dir__]
end

remove_dir 'app/assets'
remove_file 'db/seeds.rb'
remove_file 'app/views/layouts/application.html.erb'

directory 'files', './'
directory 'insert_files', 'insert_files'

# Gems
gsub_file 'Gemfile',
          "gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]",
          ''
append_to_file 'Gemfile', File.read('./insert_files/Gemfile')
run 'bundle install'

after_bundle do
  # Add yarn packages
  run "yarn add --dev #{YarnDevPackages.list.join(' ')}"
  run "yarn add #{YarnPackages.list.join(' ')}"

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

  # Config application generators
  gsub_file(
    'config/application.rb',
    'config.generators.system_tests = nil',
    File.read('./insert_files/config/application_generators.rb')
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

  remove_file 'config/locales/devise.en.yml'
  copy_file 'insert_files/config/locales/devise.en.yml',
            'config/locales/devise.en.yml'

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
  generate 'migration AddNameToUser first_name last_name username'
  generate 'migration AddOmniauthToUser provider uid'
  rails_command 'db:migrate'
  
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
  change_files CommentedFiles.list, :remove_file_comments
  change_files CommentedConfigFiles.list,
               :remove_file_comments,
               delete_blank_lines: true
  change_files MultipleWhitespaceFiles.list, :remove_file_whitespaces
  change_files CommentedJsFiles.list, :remove_js_file_comments
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

  rails_command 'db:seed'
  run 'rspec'

  # Initialize git, install overcommit and commit
  run 'overcommit --install'
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
