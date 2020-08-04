# frozen_string_literal: true

def source_paths
  [__dir__]
end

def remove_file_comments(file)
  gsub_file(file, /^\s*#.*$\n/, '')
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

remove_dir 'app/assets'
remove_file 'db/seeds.rb'

commented_files = %w[
  app/jobs/application_job.rb
  config/environments/development.rb
  config/environments/production.rb
  config/environments/test.rb
  config/initializers/application_controller_renderer.rb
  config/initializers/backtrace_silencers.rb
  config/initializers/content_security_policy.rb
  config/initializers/cookies_serializer.rb
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
  .gitignore
  config.ru
  Gemfile
  Rakefile
]

change_files commented_files, :remove_file_comments

multiple_whitespace_files = %w[
  config/environments/production.rb
  config/environments/test.rb
  config/puma.rb
]

change_files multiple_whitespace_files, :remove_file_whitespaces

copy_file 'files/.rubocop.yml', '.rubocop.yml'

gem_group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'rspec-expectations'
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

after_bundle do
  say 'After Bundle'
  rubocop_correct_all
end
