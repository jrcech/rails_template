# frozen_string_literal: true

def source_paths
  [__dir__]
end

def remove_file_comments(file)
  gsub_file(file, /^[ ]*#.*$\n/, '')
end

def remove_js_file_comments(file)
  gsub_file(file, /^[ ]*\/\/.*$\n/, '')
end

def remove_file_inline_comments(file)
  gsub_file(file, /#[\w\s]*\./, '')
end

def remove_file_whitespaces(file)
  gsub_file(file, /\S\K([ ]{2,})/, ' ')
end

def change_files(files, change_file_method)
  files.each do |file|
    send(change_file_method, file)
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
  replace_string = "#{search_line}\n#{append_string}\n"
  gsub_file(file, search_line, replace_string)
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
  config/initializers/wrap_parameters.rb
  config/locales/en.yml
  config/application.rb
  config/boot.rb
  config/database.yml
  config/environment.rb
  config/puma.rb
  config/routes.rb
  config/storage.yml
  config/webpacker.yml
  spec/rails_helper.rb
  spec/spec_helper.rb
  .gitignore
  config.ru
  Gemfile
  Rakefile
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
  postcss-import
  postcss-flexbugs-fixes
  postcss-preset-env
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

copy_file 'files/.rubocop.yml', '.rubocop.yml'
copy_file 'files/.rails_best_practices.yml', '.rails_best_practices.yml'
copy_file 'files/.reek.yml', '.reek.yml'
copy_file 'files/.overcommit.yml', '.overcommit.yml'
copy_file 'files/.eslintrc', '.eslintrc'
copy_file 'files/procfile', 'procfile'
directory 'files/spec/support', 'spec/support'
directory 'files/spec/system', 'spec/system'

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
  gem 'awesome_print'
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

gem 'devise'
gem 'rolify'

run 'bundle install'

after_bundle do
  # Add yarn packages
  run("yarn add --dev #{yarn_dev_packages.join(' ')}")
  run("yarn add #{yarn_packages.join(' ')}")

  # Create DB
  rails_command 'db:create'
  rails_command 'db:migrate'

  # Add routes
  route "root to: 'admin/frontend_test#index'"

  # Configure .gitignore
  append_to_file '.gitignore', +"\n" << gitignore_files.join("\n") << +"\n"

  # Remove redundant generated files
  remove_file 'app/javascript/controllers/hello_controller.js'

  # Configure bullet gem
  append_to_file_line(
  'config/environments/development.rb',
  'ActiveSupport::EventedFileUpdateChecker',
  bullet_environment_settings
  )

  # RSpec
  generate 'rspec:install'
  append_to_file '.rspec', "--format documentation\n--color\n"
  run 'rubocop spec/spec_helper.rb --auto-correct-all'
  prepend_to_file 'spec/rails_helper.rb', "require 'simplecov'\nSimpleCov.start\n\n"

  rails_helper_inject = %(
    require 'capybara/rails'

    Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
  )
  append_to_file_line(
        'spec/rails_helper.rb',
        "require 'rspec/rails'",
        rails_helper_inject
  )

  # Devise
  generate 'devise:install'

  devise_config = %(
    config.lock_strategy = :failed_attempts
    config.unlock_keys = [:email]
    config.unlock_strategy = :email
    config.maximum_attempts = 10
    config.last_attempt_warning = true
  )
  append_to_file_line(
      'config/initializers/devise.rb',
      'config.sign_out_via = :delete',
      devise_config
  )
  append_to_file_line(
      'config/environments/development.rb',
      'config.action_mailer.perform_caching = false',
      %(
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
        config.action_mailer.delivery_method = :letter_opener
      )
  )

  # Remove comments
  change_files commented_files, :remove_file_comments
  change_files multiple_whitespace_files, :remove_file_whitespaces
  change_files commented_js_files, :remove_js_file_comments
  remove_file_inline_comments 'config/boot.rb'

  # Fix js files
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'

  # Run autocorrection
  run 'rubocop --auto-correct-all'
  run 'yarn run eslint . --fix'

  # Initialize git, install overcommit and commit
  run 'overcommit --install'
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
