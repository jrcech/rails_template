# frozen_string_literal: true

require_relative 'support'
require_relative 'support/templates/devise'

def source_paths
  [__dir__]
end

remove_lines 'Gemfile', 'tzinfo-data'

run 'bundle install'

after_bundle do
  remove_dir 'app/assets'

  directory 'inserts', 'tmp/inserts'

  append_to_file '.gitignore', File.read('./tmp/inserts/.gitignore')

  # Format files
  remove_comments_from_files CommentedFiles.list
  remove_comments_from_file 'config/boot.rb', true
  add_blank_line 'Gemfile', "gem 'rails'"

  install_rails_linters
  install_frontend_lintes
  install_tests

  configure_application

  install_overcommit

  # Cleanup
  remove_dir 'tmp/inserts'
end

def configure_application
  # Add Procfile
  copy_file 'files/configure_application/Procfile', './Procfile'

  # Config application generators
  gsub_file(
    'config/application.rb',
    'config.generators.system_tests = nil',
    File.read('./tmp/inserts/configure_application/config/application')
  )
  run 'rubocop config/application.rb --auto-correct-all'

  # Config mailer
  inject_into_file(
    'config/environments/development.rb',
    File.read('./tmp/inserts/configure_application/config/environments/development'),
    before: 'config.action_mailer.perform_caching = false'
  )
  inject_into_file(
    'config/environments/test.rb',
    File.read('./tmp/inserts/configure_application/config/environments/test'),
    before: 'config.action_mailer.perform_caching = false'
  )
  run 'rubocop config/environments/development.rb --auto-correct-all'
  run 'rubocop config/environments/test.rb --auto-correct-all'

  # I18n
  inject_into_file(
    'app/controllers/application_controller.rb',
    File.read('./tmp/inserts/configure_application/app/controllers/application_controller'),
    after: "class ApplicationController < ActionController::Base\n"
  )
  run 'rubocop app/controllers/application_controller.rb --auto-correct-all'

  # Install gems
  append_to_file 'Gemfile', File.read('./tmp/inserts/configure_application/Gemfile')
  run 'bundle install'

  # Annotate
  run 'DISABLE_SPRING=1 rails generate annotate:install'
  remove_file 'lib/tasks/.keep'

  # ERD
  run 'DISABLE_SPRING=1 rails generate erd:install'
  append_to_file_names 'lib/templates', '.tt'

  # Seedbank
  remove_file 'db/seeds.rb'
  directory 'files/configure_application/db', './db'
end

def install_rails_linters
  append_to_file 'Gemfile', File.read('./tmp/inserts/Gemfile_linters')
  run 'bundle install'
  directory 'files/rails_linters', './'
  run 'rubocop --auto-correct-all'
end

def install_frontend_lintes
  run "yarn add --dev #{File.read('./tmp/inserts/yarn_linters').tr("\n", ' ')}"
  directory 'files/frontend_linters', './'
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'
  run "yarn add #{File.read('./tmp/inserts/yarn_postcss').tr("\n", ' ')}"
  run 'yarn run eslint . --fix'
end

def install_tests
  append_to_file 'Gemfile', File.read('./tmp/inserts/Gemfile_tests')
  run 'bundle install'

  # RSpec
  run 'DISABLE_SPRING=1 rails generate rspec:install'

  run 'rubocop spec/rails_helper.rb --auto-correct-all'
  remove_comments_from_file 'spec/rails_helper.rb'
  remove_comments_from_file 'spec/rails_helper.rb'
  remove_comments_from_file 'spec/spec_helper.rb'

  append_to_file '.rspec', "--format documentation\n--color\n"

  inject_into_file(
    'spec/rails_helper.rb',
    File.read('./tmp/inserts/rspec/spec/rails_helper'),
    after: "require 'rspec/rails'\n"
  )

  # Capybara
  inject_into_file(
    'spec/rails_helper.rb',
    "require 'capybara/rails'",
    after: "require 'rspec/rails'\n"
  )

  # Simplecov
  inject_into_file(
    'spec/rails_helper.rb',
    "require 'simplecov'\nSimpleCov.start\n\n",
    before: "require 'spec_helper'"
  )

  # Bullet
  inject_into_file(
    'config/environments/development.rb',
    File.read('./tmp/inserts/bullet/config/environments/development'),
    after: "ActiveSupport::EventedFileUpdateChecker\n"
  )

  # Configure RSpec tool
  directory 'files/rspec/spec/support', './spec/support'

  run 'rubocop spec --auto-correct-all'
  run 'rubocop config/environments/development.rb --auto-correct-all'
end

# Later
def install_overcommit
  append_to_file 'Gemfile', File.read('./tmp/inserts/Gemfile_overcommit')
  run 'bundle install'
  directory 'files/overcommit', './'
  run 'overcommit --install'
  run 'overcommit -r'
end

# Old
# remove_file 'db/seeds.rb'
# remove_file 'app/views/layouts/application.html.erb'
#
# directory 'templates', './'
# directory 'files', './'
# directory 'insert_files', 'insert_files'
#
# append_to_file_names 'lib/generators/layout/templates', '.tt'
# append_to_file_names 'lib/templates', '.tt'
#
# # Gems
# gsub_file 'Gemfile',
#           "gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]",
#           ''
# append_to_file 'Gemfile', File.read('./insert_files/Gemfile')
# run 'bundle install'
#
# after_bundle do
#   # Add yarn packages
#   run "yarn add --dev #{YarnDevPackages.list.join(' ')}"
#   run "yarn add #{YarnPackages.list.join(' ')}"
#
#   pg_status = `pg_ctl status`
#   run 'pg_ctl start' unless pg_status.include? 'server is running'
#
#   # Create DB
#   rails_command 'db:drop'
#   rails_command 'db:create'
#   rails_command 'db:migrate'
#
#   # Configure .gitignore
#   append_to_file '.gitignore', File.read('./insert_files/.gitignore')
#
#   # Remove redundant generated files
#   remove_file 'app/javascript/controllers/hello_controller.js'
#
#   # Configure bullet gem
#   inject_into_file(
#     'config/environments/development.rb',
#     File.read('./insert_files/config/environments/development_bullet.rb'),
#     after: "ActiveSupport::EventedFileUpdateChecker\n"
#   )
#
#   # Config application generators
#   gsub_file(
#     'config/application.rb',
#     'config.generators.system_tests = nil',
#     File.read('./insert_files/config/application_generators.rb')
#   )
#
#   install_rspec
#   install_devise
#
#   # I18n
#   inject_into_file(
#     'app/controllers/application_controller.rb',
#     File.read('./insert_files/app/controllers/application_controller_i18n.rb'),
#     after: "class ApplicationController < ActionController::Base\n"
#   )
#
#   # Annotate
#   generate 'annotate:install'
#   remove_file 'lib/tasks/.keep'
#
#   # ERD
#   generate 'erd:install'
#
#   # Remove comments
#   change_files CommentedFiles.list, :remove_file_comments
#
#   change_files(
#     CommentedConfigFiles.list,
#     :remove_file_comments,
#     delete_blank_lines: true
#   )
#
#   change_files MultipleWhitespaceFiles.list, :remove_file_whitespaces
#   change_files CommentedJsFiles.list, :remove_js_file_comments
#   remove_file_inline_comments 'config/boot.rb'
#
#   # Fix js files
#   prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
#   gsub_file 'babel.config.js', 'function(api)', '(api) =>'
#
#   # JS
#   prepend_to_file(
#     'app/javascript/packs/application.js',
#     File.read('./insert_files/app/javascript/packs/application.js')
#   )
#
#   # Provide plugin
#   inject_into_file(
#     'config/webpack/environment.js',
#     File.read('./insert_files/config/webpack/environment.js'),
#     after: "const { environment } = require('@rails/webpacker')\n"
#   )
#
#   # Remove insert files
#   remove_dir 'insert_files'
#
#   # Run autocorrection
#   run 'rubocop --auto-correct-all'
#   run 'yarn run eslint . --fix'
#   run 'annotate'
#
#   rails_command 'db:seed'
#   run 'rspec'
#
#   # Initialize git, install overcommit and commit
#   run 'overcommit --install'
#   git :init
#   git add: '.'
#   git commit: "-a -m 'Initial commit'"
# end
