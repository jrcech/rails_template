# frozen_string_literal: true

require_relative 'support'

Dir[File.join(__dir__, 'processes', '**', '*.rb')].each { |f| require f }

def source_paths
  [__dir__]
end

install_generators

configure_database

add_blank_line 'Gemfile', "gem 'rails'"
remove_lines 'Gemfile', 'tzinfo-data'

directory 'inserts', 'tmp/inserts'

run 'bundle install'

after_bundle do
  remove_dir 'app/assets'

  run 'spring stop'

  install_rails_linters
  install_frontend_linters
  install_tests
  install_devise

  configure_application
  configure_frontend

  install_overcommit

  remove_dir 'tmp/inserts'

  run 'rspec'

  # Run autocorrection
  # run 'rubocop --auto-correct-all'
  # run 'yarn run eslint . --fix'
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
