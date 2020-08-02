# frozen_string_literal: true

def source_paths
  Array(super) + [File.expand_path(File.dirname(__FILE__))]
end

def remove_file_comments(file)
  gsub_file(file, /^\s*#.*$\n/, '')
end

def remove_all_comments(files)
  files.each do |file|
    remove_file_comments file
  end
end

def remove_file_whitespaces(file)
  gsub_file(file, /\S\K([ ]{2,})/, ' ')
end

def remove_all_whitespaces(files)
  files.each do |file|
    remove_file_whitespaces file
  end
end

def rubocop_file(file)
  run("rubocop -a #{file}")
end

def rubocop_correct_all
  run("rubocop -a")
end

def rubocop_files(files)
  files.each do |file|
    rubocop_file file
  end
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

remove_all_comments commented_files

multiple_whitespace_files = %w[
config/environments/production.rb
config/environments/test.rb
config/puma.rb
]

remove_all_whitespaces multiple_whitespace_files

copy_file 'files/.rubocop.yml', '.rubocop.yml'
rubocop_correct_all
